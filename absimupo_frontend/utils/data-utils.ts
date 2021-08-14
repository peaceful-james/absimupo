import { ImageInfo } from "expo-image-picker/build/ImagePicker.types";
import { Uploadable } from "relay-runtime";

export function imageInfoToUploadable(
  imageInfo: ImageInfo | undefined
): Uploadable | undefined {
  if (!imageInfo) {
    return undefined;
  } else if (imageInfo.uri.startsWith("file")) {
    return imageInfoToFile(imageInfo);
  } else {
    return imageInfoToBlob(imageInfo);
  }
}

export function imageInfoToFile(imageInfo: ImageInfo) {
  const { uri, width, height, type: dataType } = imageInfo;
  return dataUriToFile(uri, width, height, dataType || "");
}

export function imageInfoToBlob(imageInfo: ImageInfo) {
  return dataUriToBlob(imageInfo.uri);
}

export function dataUriToFile(
  dataUri: string,
  width: number,
  height: number,
  dataType: string
) {
  const fileType = dataUri.split(".").reverse()[0];
  const name = dataUri.split("/").reverse()[0];
  return {
    uri: dataUri,
    name,
    type: `${dataType}/${fileType}`,
    size: width * height,
    ...dummyFilePropsForTypescript(dataUri),
  };
}

export function dataUriToBlob(dataUri: string) {
  //https://stackoverflow.com/questions/6850276/how-to-convert-dataurl-to-file-object-in-javascript
  // convert base64 to raw binary data held in a string
  // doesn't handle URLEncoded DataURIs - see SO answer #6850276 for code that does this
  var { byteString, arrayBuffer } = dataUriToByteStringAndArrayBuffer(dataUri);
  // separate out the mime component
  var mimeString = dataUri.split(",")[0].split(":")[1].split(";")[0];
  // write the bytes of the string to an ArrayBuffer
  var dw = new DataView(arrayBuffer);
  for (var i = 0; i < byteString.length; i++) {
    dw.setUint8(i, byteString.charCodeAt(i));
  }
  // write the ArrayBuffer to a blob, and you're done
  return new Blob([arrayBuffer], { type: mimeString });
}

function dataUriToByteStringAndArrayBuffer(dataUri: string) {
  var byteString = atob(dataUri.split(",")[1]);
  return {
    byteString,
    arrayBuffer: new ArrayBuffer(byteString.length),
  };
}

function dummyFilePropsForTypescript(dataUri: string) {
  return {
    lastModified: 0,
    arrayBuffer: async () =>
      dataUriToByteStringAndArrayBuffer(dataUri).arrayBuffer,
    slice: () => new Blob(),
    stream: () => new ReadableStream(),
    text: async () => "",
  };
}
