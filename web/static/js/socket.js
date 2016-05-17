import { Socket, LongPoller } from "phoenix";

let socket = new Socket("/socket", {
  logger: ((kind, msg, data) => { console.log(`${kind}: ${msg}`, data) }),
});

socket.connect();

export default socket;
