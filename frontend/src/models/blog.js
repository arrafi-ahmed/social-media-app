export default class Blog {
  constructor ({
                id = null,
                title = '',
                description = '',
                image = '',
                userId = null,
                createdAt = null,
              } = {}) {
    this.id = id
    this.title = title
    this.description = description
    this.image = image
    this.userId = userId
    this.createdAt = createdAt
  }
}
