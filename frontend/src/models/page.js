export default class Page {
  constructor ({ id = null, title = '', description = '', name = '' } = {}) {
    this.id = id
    this.title = title
    this.description = description
    this.name = name
  }
}
