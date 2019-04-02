# peking

> A Vue.js project

## Build Setup

``` bash
# install dependencies
npm install

# serve with hot reload at localhost:8080
npm run dev

# build for production with minification
npm run build

# build for production and view the bundle analyzer report
npm run build --report

# run unit tests
npm run unit

# run all tests
npm test
```

For a detailed explanation on how things work, check out the [guide](http://vuejs-templates.github.io/webpack/) and [docs for vue-loader](http://vuejs.github.io/vue-loader).


## TODO:

### Page:
- [x] 404
- [x] signin
- [x] home
  - [x] navbar
  - [x] sidebar
  - [x] search_box
  - [x] room_card(click handle)
- [ ] profile
  - [x] collection
  - [x] self_info
  - [ ] teacher
  - [x] test
- [ ] live video
  - [x] layout
  - [ ] player
  - [ ] editor
  - [ ] danmu
- [ ] dashborad
  - [ ] room_manager
  - [x] statistics
  - [ ] student_manager
  - [ ] test_manager

### Router:
- [x] Authenticate
- [x] Redirect

### Function:
- [x] Permission
- [x] FetchData
- [ ] Websocket
- [ ] MediaServer
- [ ] HighLight
- [ ] AutoComplete

### Model
#### User
- id
- email
- phone
- avatar
- role
- description
- nickname
- created_at
- last_login_at

#### Article
- id
- author_id
- title
- content
- views
- collection

#### Room
- id
- own_id
- title
- token
- views
- status
- category
- collection
- last_start_at

#### Room_collection

#### Exercise

#### Grade

#### TODO

#### Comment
