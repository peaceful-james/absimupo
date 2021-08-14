export default ({ config }) => {
  const extra = {
    wsUrl: process.env.REACT_APP_ABSIMUPO_EXPO_WS_URL || "ws://localhost:4000/socket",
    httpUrl: process.env.REACT_APP_ABSIMUPO_EXPO_HTTP_URL || "http://localhost:4000/api"
  };
  return {
    ...config,
    extra,
  };
};
