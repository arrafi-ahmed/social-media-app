export default class Event {
  constructor(
    title,
    date,
    start_time,
    end_time,
    location,
    description,
    category,
    images,
    is_featured,
    user_id
  ) {
    this.title = title;
    this.date = date;
    this.start_time = start_time;
    this.end_time = end_time;
    this.location = location;
    this.description = description;
    this.category = category;
    this.images = images;
    this.is_featured = is_featured || false;
    this.user_id = user_id;
  }
}
