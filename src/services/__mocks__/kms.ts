export const signMock = jest.fn(() => "0x0asd0j234nsd0");

jest.doMock("../kms", () => ({
  sign: signMock,
}));
