import Mock from 'mockjs'
import * as loginAPI from './login'


// 登录相关
Mock.mock(/\/api\/login/, 'post', loginAPI.loginByUsername)
Mock.mock(/\/api\/logout/, 'post', loginAPI.logout)
Mock.mock(/\/api\/user\/info\.*/, 'get', loginAPI.getUserInfo)


export default Mock
