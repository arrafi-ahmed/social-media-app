export default class User {
  constructor ({
                id = null,
                fullName = '',
                email = '',
                dateOfBirth = null,
                country = '',
                image = '',
                slug = '',
                role = 20,
                theme = 'light',
                createdAt = null,
              } = {}) {
    this.id = id
    this.fullName = fullName
    this.email = email
    this.dateOfBirth = dateOfBirth
    this.country = country
    this.image = image
    this.slug = slug
    this.role = role
    this.theme = theme
    this.createdAt = createdAt
  }
}
