import Mock from 'mockjs'
import * as loginAPI from './login'
import * as roomAPI from './room'
import * as articleAPI from './article'

Mock.mock(/\/api\/login/, 'post', loginAPI.loginByUsername)
Mock.mock(/\/api\/logout/, 'post', loginAPI.logout)
Mock.mock(/\/api\/user\/info\.*/, 'get', loginAPI.getUserInfo)

Mock.mock(/\/api\/rooms\/.+/, 'get', roomAPI.getRoomInfo)
Mock.mock(/\/api\/rooms/, 'get', roomAPI.getRoomList)

Mock.mock(/\/api\/article\/list/, 'get', articleAPI.getList)
Mock.mock(/\/api\/article\/detail/, 'get', articleAPI.getArticle)
Mock.mock(/\/api\/article\/pv/, 'get', articleAPI.getPv)
Mock.mock(/\/api\/article\/create/, 'post', articleAPI.createArticle)
Mock.mock(/\/api\/article\/update/, 'post', articleAPI.updateArticle)

export default Mock
