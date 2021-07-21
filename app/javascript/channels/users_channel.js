import consumer from "./consumer"

const UsersChannel = consumer.subscriptions.create("UsersChannel", {});

export default UsersChannel;
