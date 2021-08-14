const tintColorLight = "#2f95dc";
const tintColorDark = "#fff";

export type Colors = {
  text: string;
  textInputPlaceholder: string;
  textInputPlaceholderDisabled: string;
  background: string;
  backgroundTint: string;
  tint: string;
  tabIconDefault: string;
  tabIconSelected: string;
  primary: string;
  primaryTint: string;
  error: string;
  anchorTextColor: string;
};

const light: Colors = {
  text: "#3E3C41",
  textInputPlaceholder: "#222222",
  textInputPlaceholderDisabled: "#222222",
  tint: tintColorLight,
  tabIconDefault: "#cccccc",
  tabIconSelected: tintColorLight,
  background: "#F7EEE0",
  backgroundTint: "#fdfcf9",
  primary: "#BB3F20",
  primaryTint: "#dd9f90",
  error: "#ff0033",
  anchorTextColor: "#0000ff",
};

const dark: Colors = {
  text: "#F7EEE0",
  textInputPlaceholder: "#cfcfcf",
  textInputPlaceholderDisabled: "#222222",
  background: "#3E3C41",
  backgroundTint: "#515054",
  tint: tintColorDark,
  tabIconDefault: "#cccccc",
  tabIconSelected: tintColorDark,
  primary: "#BB3F20",
  primaryTint: "#dd9f90",
  error: "#ff0033",
  anchorTextColor: "#8080ff",
};

export default {
  light,
  dark,
};
