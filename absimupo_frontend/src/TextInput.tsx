import React, { Dispatch, SetStateAction, useEffect, useState } from "react";
import {
  StyleSheet,
  Text,
  TextInput as RNTextInput,
  TextInputProps as RNTextInputProps,
  TextStyle,
  View,
} from "react-native";
import { useTheme } from "../contexts/ThemeContext";

interface TextInputProps extends RNTextInputProps {
  errorMessage?: string;
}

export const useTextInput = (
  initialValue: string = ""
): [
  textInputProps: {
    value: string;
    onChangeText: Dispatch<SetStateAction<string>>;
    errorMessage: string;
  },
  setValue: (value: string) => void,
  setErrorMessage: (message?: string) => void
] => {
  const [value, onChangeText] = useState<string>(initialValue);
  const [errorMessage, setErrorMessage] = useState<string>("");
  const textInputProps = {
    value,
    onChangeText,
    errorMessage,
  };
  const setErrorMessageWithDefault = (message: string = "") => setErrorMessage(message)
  useEffect(() => {
    setErrorMessageWithDefault();
  }, [value]);
  return [textInputProps, onChangeText, setErrorMessageWithDefault];
};

const TextInput = ({ errorMessage, ...props }: TextInputProps) => {
  const { colors } = useTheme();
  const baseTextInputStyle: TextStyle = {
    borderTopLeftRadius: 8,
    borderTopRightRadius: 8,
    borderWidth: 1,
    borderBottomWidth: 2,
    fontSize: 16,
    paddingTop: 8,
    paddingBottom: 8,
    paddingLeft: 8,
  };
  const disabled: boolean = props.editable === false;
  const styles = StyleSheet.create({
    textInput: {
      backgroundColor: disabled ? "#d3d3d3" : "transparent",
      borderColor: errorMessage ? colors.error : colors.primary,
      color: disabled ? "#d3d3d3" : errorMessage ? colors.error : colors.text,
      ...baseTextInputStyle,
    },
    errorMessage: {
      color: colors.error,
    },
    label: {
      color: errorMessage ? colors.error : colors.primary,
    },
  });
  return (
    <View style={styles.root}>
      {!!props.value && props.placeholder && (
        <Text style={styles.label}>{props.placeholder}</Text>
      )}
      <RNTextInput
        {...props}
        placeholderTextColor={
          disabled
            ? colors.textInputPlaceholderDisabled
            : colors.textInputPlaceholder
        }
        testID={"text-input " + props.placeholder}
        style={styles.textInput}
      />
      {!!errorMessage && (
        <Text style={styles.errorMessage}>{errorMessage}</Text>
      )}
    </View>
  );
};

export default TextInput;
