import * as jspb from 'google-protobuf'



export class Compiler extends jspb.Message {
  getName(): string;
  setName(value: string): Compiler;

  serializeBinary(): Uint8Array;
  toObject(includeInstance?: boolean): Compiler.AsObject;
  static toObject(includeInstance: boolean, msg: Compiler): Compiler.AsObject;
  static serializeBinaryToWriter(message: Compiler, writer: jspb.BinaryWriter): void;
  static deserializeBinary(bytes: Uint8Array): Compiler;
  static deserializeBinaryFromReader(message: Compiler, reader: jspb.BinaryReader): Compiler;
}

export namespace Compiler {
  export type AsObject = {
    name: string,
  }
}

