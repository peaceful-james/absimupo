import React, { ReactNode } from "react";
import { StyleSheet, View } from "react-native";
import { useTheme } from "../contexts/ThemeContext";

type FormRootProps = {
  children: ReactNode;
};

const FormRoot = ({ children }: FormRootProps) => {
  const { colors } = useTheme();
  const styles = StyleSheet.create({
    root: {
      flexDirection: "row",
      justifyContent: "center",
      backgroundColor: colors.background,
    },
    innerRoot: {
      flex: 1,
      maxWidth: 300,
    },
  });
  return (
    <View style={styles.root}>
      <View style={styles.innerRoot}>{children}</View>
    </View>
  );
};

export default FormRoot;
