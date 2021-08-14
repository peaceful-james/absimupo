import { Uploadable, UploadableMap } from "relay-runtime";

export async function generateForm(
  operation: { text: string },
  variables: {
    input: {
      [key: string]: Uploadable | string;
    };
  },
  uploadables: UploadableMap
) {
  let formData = new FormData();
  const input = { ...variables.input };
  await Promise.all(
    Object.entries(uploadables).map(async ([key, value]) => {
      formData.append(key, value);
      input[key] = key;
    })
  );
  formData.append("query", operation.text);
  formData.append("variables", JSON.stringify({ ...variables, input }));
  return formData;
}
