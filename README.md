# peking

> A Vue.js project

## Build Setup

``` bash
# install  dependencies
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
学生端:
  - 查看作业
  - 查看统计
  - 关注直播间
教师端
  - 申请直播间
  - 查看教学统计
  - 查看学生
管理端
  - 管理直播间

### Router:
- [x] Authenticate
- [x] Redirect

### Function:
- [x] Permission
- [x] FetchData
- [x] Websocket
- [x] MediaServer

### Model
#### User
- id
- email
- avatar
- role
- description
- nickname
- created_at
- last_login_at


#### Article
- id
- author_id(belong_to :user)
- title
- content
- views
- collection

#### Room
- id
- own_id(belong_to :user)
- title
- token
- views
- status
- category
- collection
- last_start_at

#### Exercise
- id
- title
- answer

#### Question
- id
- title
- answer

#### Grade

#### TODO

#### Comment
