import { ImageInfo } from "expo-image-picker/build/ImagePicker.types";
import React, { useState } from "react";
import { graphql, useMutation } from "react-relay";
import { Pressable, StyleSheet, Text, View } from "react-native";
import { UploadableMap } from "relay-runtime";
import { useTheme } from "../contexts/ThemeContext";
import FormRoot from "./FormRoot";
import ImagePicker from "./ImagePicker";
import TextInput, { useTextInput } from "./TextInput";
import { imageInfoToUploadable } from "../utils/data-utils";
import type {
  CreateThingFormMutationVariables,
  CreateThingFormMutation as CreateThingFormMutationType,
  CreateThingFormMutationResponse,
  ThingInput,
} from "./__generated__/CreateThingFormMutation.graphql";

const CreateThingFormMutation = graphql`
  mutation CreateThingFormMutation($input: ThingInput!) {
    thing: createThing(input: $input) {
      errors {
        key
        message
        statusCode
      }
      thing {
        edges {
          cursor
          node {
            id
            name
            imageUrlLogo
          }
        }
      }
    }
  }
`;

const CreateThingForm = () => {
  const { colors } = useTheme();
  const [commit, isInFlight] = useMutation<CreateThingFormMutationType>(
    CreateThingFormMutation
  );
  const [name, setName, setNameError] = useTextInput();
  const [logoImageInfo, setLogoImageInfo] =
    useState<ImageInfo | undefined>(undefined);
  const [generalErrors, setGeneralErrors] = useState<string[]>([]);

  const resetForm = () => {
    setName("");
    setLogoImageInfo(undefined);
  };

  const resetErrors = () => {
    setNameError();
    setGeneralErrors([]);
  };

  const handleSubmit = () => {
    resetErrors();
    const logo = imageInfoToUploadable(logoImageInfo);
    const input: ThingInput = {
      logo,
      name: name.value,
    };
    const variables: CreateThingFormMutationVariables = { input };
    const uploadables: UploadableMap = logo ? { logo } : {};
    const onCompleted = (response: CreateThingFormMutationResponse) => {
      if (!response.thing) {
        setGeneralErrors(["No Response From the Backend"]);
        return;
      }
      const { errors, thing } = response.thing;
      if (!!errors && errors.length > 0) {
        errors.forEach((error) => {
          if (error) {
            const { key, message } = error;
            switch (key) {
              case "name":
                setNameError(message);
                break;
              default:
                setGeneralErrors((prevState) => [...prevState, message]);
            }
          }
        });
        return;
      } else {
        resetForm();
        return;
      }
    };
    commit({ variables, uploadables, onCompleted });
  };
  const styles = StyleSheet.create({
    row: {
      flexDirection: "row",
      marginBottom: 16,
    },
    errorText: {
      color: colors.error,
    },
    text: {
      color: colors.text,
      fontSize: 20,
    },
    button: {
      alignItems: "center",
      justifyContent: "center",
      paddingVertical: 12,
      borderRadius: 4,
      elevation: 3,
      backgroundColor: colors.primary,
    },
  });
  return (
    <FormRoot>
      <View style={styles.row}>
        <View>
          <ImagePicker
            disabled={isInFlight}
            handleResult={(result: ImageInfo) => setLogoImageInfo(result)}
            title="Select logo for new Thing"
            uri={logoImageInfo?.uri}
          />
        </View>
        <View style={{ flexShrink: 1 }}>
          <TextInput placeholder="Name" {...name} editable={!isInFlight} />
          <Pressable
            style={styles.button}
            disabled={isInFlight}
            onPress={handleSubmit}
          >
            <Text>Create new Thing</Text>
          </Pressable>
          {generalErrors.map((message, index) => (
            <Text key={`create-thing-error-${index}`} style={styles.errorText}>
              {message}
            </Text>
          ))}
        </View>
      </View>
    </FormRoot>
  );
};

export default CreateThingForm;
