import axios from "axios";

const DEFAULT_API_PREFIX = "/app2-api";
const backendBaseURL = import.meta.env.VITE_BACKEND_URL?.trim();
const resolvedBaseURL =
  backendBaseURL && backendBaseURL !== "/"
    ? backendBaseURL
    : DEFAULT_API_PREFIX;

const instance = axios.create({
  baseURL: resolvedBaseURL,
});
const refreshInstance = axios.create({
  baseURL: resolvedBaseURL,
});
const handleRefreshToken = async () => {
  try {
    const refreshToken = localStorage.getItem("refreshToken");
    if (!refreshToken) return null;
    const res = await refreshInstance.post("/api/Authentication/RefreshToken", {
      refreshToken,
    });
    if (res && res.access_token) {
      localStorage.setItem("token", res.access_token);
      if (res.refreshToken) {
        localStorage.setItem("refreshToken", res.refreshToken);
      }
      return res.access_token;
    }
    return null;
  } catch (error) {
    return null;
  }
};
instance.interceptors.request.use(
  function (config) {
    // Do something before request is sent
    const token = localStorage.getItem("token");
    const auth = token ? `Bearer ${token}` : "";
    config.headers["Authorization"] = auth;
    return config;
  },
  function (error) {
    // Do something with request error
    return Promise.reject(error);
  }
);

// Add a response interceptor
instance.interceptors.response.use(
  function (response) {
    // Any status code that lie within the range of 2xx cause this function to trigger
    // Do something with response data
    if (response && response?.data) return response.data;
    return response;
  },
  async function (error) {
    // Any status codes that falls outside the range of 2xx cause this function to trigger
    // Do something with response error

    if (error.config && error.response && +error.response.status === 401) {
      const access_token = await handleRefreshToken();
      if (access_token) {
        error.config.headers["Authorization"] = `Bearer ${access_token}`;
        localStorage.setItem("token", access_token);
        return instance.request(error.config);
      }
    }

    const normalizedError =
      error?.response?.data ?? error?.response ?? error;
    return Promise.reject(normalizedError);
  }
);
export default instance;
