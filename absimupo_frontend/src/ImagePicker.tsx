import React, { useEffect, useState } from "react";
import { Image, Platform, Pressable, Text } from "react-native";
import * as ExpoImagePicker from "expo-image-picker";
import {
  ImageInfo,
  ImagePickerResult,
} from "expo-image-picker/build/ImagePicker.types";

type ImagePickerProps = {
  handleResult: (result: ImageInfo) => void;
  uri: string | undefined;
  title: string;
  disabled: boolean;
};
import { useTheme } from "../contexts/ThemeContext";

export default function ImagePicker({
  disabled,
  handleResult,
  title,
  uri,
}: ImagePickerProps) {
  const { colors } = useTheme();
  useEffect(() => {
    (async () => {
      if (Platform.OS !== "web") {
        const { status: _cameraStatus } =
          await ExpoImagePicker.requestCameraPermissionsAsync();
        const { status: mediaLibraryStatus } =
          await ExpoImagePicker.requestMediaLibraryPermissionsAsync();
        if (mediaLibraryStatus !== "granted") {
          alert("Sorry, we need camera roll permissions to make this work!");
        }
      }
    })();
  }, []);

  const pickImage = async () => {
    let result: ImagePickerResult =
      await ExpoImagePicker.launchImageLibraryAsync({
        mediaTypes: ExpoImagePicker.MediaTypeOptions.Images,
        allowsEditing: true,
        aspect: [4, 3],
        quality: 1,
      });

    if (!result.cancelled) {
      handleResult(result);
    }
  };

  const size = { width: 150, height: 150 };

  return (
    <Pressable
      disabled={disabled}
      onPress={pickImage}
      style={{ ...size, backgroundColor: colors.backgroundTint }}
    >
      {uri ? (
        <Image source={{ uri }} style={{ ...size }} />
      ) : (
        <Text
          style={{
            ...size,
            color: colors.text,
            fontSize: 20,
            textAlign: "center",
            textAlignVertical: "center",
          }}
        >
          {title}
        </Text>
      )}
    </Pressable>
  );
}
