export default class Friendship {
  constructor ({
                id = null,
                userId1 = null,
                userId2 = null,
                createdAt = null,
              } = {}) {
    this.id = id
    this.userId1 = userId1
    this.userId2 = userId2
    this.createdAt = createdAt
  }
}
