![](https://img.shields.io/badge/Microverse-blueviolet)

# Capstone Project: HTML & CSS

> This is a capstone project for the HTML and CSS section of the Technical Skills course.

![screenshot](./app_screenshot.png)

A capstone project is the closing project that students will solo-perform. It is designed to assess the student's technical and professional skills from the block that it is closing. For this project, a concept, responsive, mobile-first web page is presented.

## Design Considerations

This project's approach was thinking of it as a client reached me with an idea for its website. From that idea, I gave myself creative freedom, so it will not look 100% the same.

Some small details may change for any of the following reasons:
- The color schema is not in-line with the subject, for this, I provide an alternative color schema that fits better
- There are some changes in color, backgrounds, borders, shadows, and tints to improve contrast and usability
- The footer bar is over-simplified on purpose because a heavily filled footer may distract the user from reaching the main information, which is the ultimate goal
- When designing the results cards, I decided to make them similar to Bootstrap cards because users may need a sneak peek of the actual content to click the result
  - The original design, instead, uses a background with white text in the middle because, in their subject, a sneak peek is not actually as valuable as, for example, the distance from the user to the institution
- The filter form is hidden inside a `details` tag, which is closed by default because it may draw the attention of the user earlier than expected
  - I actually want the user to navigate through the results before filtering them, but without forcing them to reach the bottom of the page to find the filter form
- Inside the details page, I added a card that shows the complete information from the sneak peek. This is because that was what drew the user's attention in the first place, and they may want to find it out sooner rather than later
- Inside the details page, you may find some text which resembles a blog entry or an article
  - This is also intentional because the subject (rare diseases) ofter requires documentation and investigation. Therefore, giving the client a space to express what they are doing or who they are may serve better to connect the user to the institution
- If the user is interested enough, the user can show the information card with valuable details compacted in a card; but is not showed by default. Only users interested enough may want to see the information card
  - The information card contains the details that the filter form can filter by, so this offers a valuable piece of information, yet we don't want users not interested to see the `Apply` button
- One of the most important details of the results, just after the details card, is the exact location. Users may find interesting information and have a will to apply, but they may be stopped when they see the exact location (because it may not be convenient to them)
- From the point above, the actual business contact information is way to the bottom, only when the user is convinced that the exact location may not be an impediment or may want to gather more details directly from the institution

## Built With

- NoTengoBattery's `html-css-template` template and it's automation scripts
- HTML
- SCSS/SASS
- Bootstrap
- Free assets sites
  - Coverr
  - Unsplash
  - FontAwesome
  - Lipsum (Lorem Ipsum)
  - Google Fonts
  - Adobe Fonts
  - Coolors

## Live Demo

[Live Demo Link](https://notengobattery.github.io/capstone-html/)

- To reach the results page from the main page, click on the search button either in the navbar or in the landing cover
- To reach the details page, from the results page, click on any results card

### Original Design Version

Because of the subject that this page discusses, using a funny orange color does not serve the purpose well. For this reason, I created an alternative theme with my own selection of colors. The links inside the page do not work due to the limitations of the service used to provide the demo, but you can browse them, one by one, following the links below.

- [Landing](https://htmlpreview.github.io/?https://github.com/NoTengoBattery/capstone-html/blob/original-design/index.html)
- [Results](https://htmlpreview.github.io/?https://github.com/NoTengoBattery/capstone-html/blob/original-design/src/html/results.html)
- [Details](https://htmlpreview.github.io/?https://github.com/NoTengoBattery/capstone-html/blob/original-design/src/html/detail.html)

> Note that while this service is useful, it is not as fast as GitHub pages, so you will experience jitter while the stylesheet reloads. Some web page details may not be rendered correctly, but this is the same as the GitHub page, just with the different color schema. **IT DOES NOT WORK ON FIREFOX**

## Getting Started

For this project, you only need to follow the link to the live demo. If you need a copy of this project in your local environment, you can clone this repository using `git`.

### Usage

For testing and using this project, you need to open the `index.html` file in your browser at the repository root. No other special requirements or tools are needed.

## Authors

👤 **Oever González**

- GitHub: [@NoTengoBattery](https://github.com/NoTengoBattery)
- Twitter: [@NoTengoBattery](https://twitter.com/NoTengoBattery)
- LinkedIn: [LinkedIn](https://linkedin.com/in/NoTengoBattery)

## 🤝 Contributing

Contributions, issues, and feature requests are welcome!

Feel free to check the [issues page](issues/).

## Show your support

Give a ⭐️ if you like this project!

## Acknowledgments

- Mathew Njuguna
- RedHat for it's wonderful Liberation font family
- Fabrizio Bianchi for his amazing Coolors tool

## 📝 License

This project is [X11](https://spdx.org/licenses/X11.html) licensed.
