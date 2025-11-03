export default class EventFavorite {
  constructor ({
                id = null,
                userId = null,
                eventId = null,
                createdAt = null,
              } = {}) {
    this.id = id
    this.userId = userId
    this.eventId = eventId
    this.createdAt = createdAt
  }
}
