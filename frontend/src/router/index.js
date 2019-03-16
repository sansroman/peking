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
  },
  {
    path: '/profile',
    name: 'profile',
    component: () => import('@/pages/Profile'),
    children: [
      {
        name: 'todo',
        path: 'todo',
        component: () => import('@/pages/subView/TODO')
      },
      {
        name: 'statistics',
        path: 'statistics',
        component: () => import('@/pages/subView/Statistics')
      },
      {
        name: 'setting',
        path: 'setting',
        component: () => import('@/pages/subView/Setting')
      },
      {
        name: 'test',
        path: 'test',
        component: () => import('@/pages/subView/Test'),
        children: [
          {
            path: ':id',
            name: 'testDetail',
            component: () => import('@/pages/subView/TestDetail')
          }
        ]
      },
      {
        name: 'task',
        path: 'task',
        component: () => import('@/pages/subView/Task')
      },
      {
        name: 'course',
        path: 'course',
        component: () => import('@/pages/subView/Course')
      }
    ]
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
