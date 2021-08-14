import React from "react";
import {
  Pressable,
  Platform,
  PressableProps,
  StyleSheet,
  Text,
} from "react-native";
import { useTheme } from "../contexts/ThemeContext";

interface PrimaryButton extends PressableProps {
  title: string;
}

const PrimaryButton = ({ title, ...props }: PrimaryButton) => {
  const { colors } = useTheme();
  const platformDependantButtonStyles =
    Platform.OS == "web" ? { cursor: "pointer" } : {};
  const styles = StyleSheet.create({
    button: {
      margin: 8,
      borderRadius: 4,
      paddingHorizontal: 8,
      ...platformDependantButtonStyles,
    },
    text: {
      margin: 8,
      textAlign: "center",
      color: "white",
    },
  });
  return (
    <Pressable
      testID={"primary-button " + title}
      {...props}
      style={({ pressed }) => [
        {
          backgroundColor: pressed ? colors.primaryTint : colors.primary,
        },
        styles.button,
      ]}
    >
      {({ pressed }) => <Text style={styles.text}>{title}</Text>}
    </Pressable>
  );
};

export default PrimaryButton;
