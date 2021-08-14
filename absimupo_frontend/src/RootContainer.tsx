import React from "react";
import { StyleSheet, View } from "react-native";
import { useTheme } from "../contexts/ThemeContext";

type Props = {
  children: React.ReactNode
}
const RootContainer = (props: Props) => {
  const { colors } = useTheme();
  const styles = StyleSheet.create({
    container: {
      flex: 1,
      backgroundColor: colors.background,
    },
  });
  return <View style={styles.container}>{props.children}</View>;
};

export default RootContainer;
