import Vue from 'vue'
import Router from 'vue-router'
import Layout from '@/pages/layout/Layout'

Vue.use(Router)
const constantRouter = [
  {
    path: '/login',
    component: () => import('@/pages/Login')
  },
  {
    path: '/404',
    component: () => import('@/pages/404')
  },
  {
    path: '/room',
    component: Layout,
    children: [{
      path: ':id',
      name: 'room',
      component: () => import('@/pages/Room')
    }]
  }
]
const asyncRouters = [
  {
    path: '/',
    component: Layout,
    children: [
      {
        path: '',
        component: () => import('@/pages/Home'),
        name: 'Home',
        meta: {
          title: 'Home',
          icon: 'lock'
        }
      }
    ]
  },
  {
    path: '/hot',
    component: Layout,
    children: [
      {
        path: '',
        name: 'hot',
        meta: {
          title: 'hot',
          icon: 'eye'
        }
      }
    ]
  },
  {
    path: '/star',
    component: Layout,
    children: [{
      path: '',
      name: 'star',
      meta: {
        title: 'star',
        icon: 'star'
      }
    }]
  }
]
export default new Router({
  routes: constantRouter
})
export { asyncRouters }
