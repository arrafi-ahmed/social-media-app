export default class Invitation {
  constructor ({
                id = null,
                senderId = null,
                receiverEmail = '',
                token = '',
                isAccepted = false,
                createdAt = null,
              } = {}) {
    this.id = id
    this.senderId = senderId
    this.receiverEmail = receiverEmail
    this.token = token
    this.isAccepted = isAccepted
    this.createdAt = createdAt
  }
}
