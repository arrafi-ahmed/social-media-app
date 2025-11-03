export default class Comment {
  constructor ({
                id = null,
                eventId = null,
                userId = null,
                text = '',
                createdAt = null,
              } = {}) {
    this.id = id
    this.eventId = eventId
    this.userId = userId
    this.text = text
    this.createdAt = createdAt
  }
}
