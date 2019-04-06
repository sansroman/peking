import Vue from 'vue'
import Router from 'vue-router'
import Layout from '@/pages/layout/Layout'

Vue.use(Router)
const asyncRouters = [
  {
    path: '/profile',
    name: 'profile',
    redirect: '/profile/setting',
    meta: {
      roles: ['student', 'teacher']
    },
    component: () => import('@/pages/Profile'),
    children: [
      {
        name: 'todo',
        path: 'todo',
        meta: {
          roles: ['student', 'teacher']
        },
        component: () => import('@/pages/subView/TODO')
      },
      {
        name: 'statistics',
        path: 'statistics',
        meta: {
          roles: ['student']
        },
        component: () => import('@/pages/subView/Statistics')
      },
      {
        name: 'teacherStatistics',
        path: 'teacherStatistics',
        meta: {
          roles: ['teacher']
        },
        component: () => import('@/pages/subView/TeacherStatistics')
      },
      {
        name: 'setting',
        path: 'setting',
        meta: {
          roles: ['student', 'teacher']
        },
        component: () => import('@/pages/subView/Setting')
      },
      {
        name: 'test',
        path: 'test',
        component: () => import('@/pages/subView/Test'),
        meta: {
          roles: ['student']
        },
        children: [
          {
            path: ':id',
            name: 'testDetail',
            component: () => import('@/pages/subView/TestDetail')
          }
        ]
      },
      {
        name: 'course',
        path: 'course',
        meta: {
          roles: ['student']
        },
        component: () => import('@/pages/subView/Course')
      },
      {
        name: 'testManager',
        path: 'testManager',
        meta: {
          roles: ['teacher']
        },
        component: () => import('@/pages/subView/TestManager')
      },
      {
        name: 'studentManager',
        path: 'studentManager',
        meta: {
          roles: ['teacher']
        },
        component: () => import('@/pages/subView/StudentManager')
      },
      {
        name: 'myRoom',
        path: 'myRoom',
        meta: {
          roles: ['teacher']
        },
        component: () => import('@/pages/subView/MyRoom')
      },
      {
        name: 'roomManager',
        path: 'roomManager',
        meta: {
          roles: ['admin']
        },
        component: () => import('@/pages/subView/RoomManager')
      },
      {
        name: 'userManager',
        path: 'userManager',
        meta: {
          roles: ['admin']
        },
        component: () => import('@/pages/subView/UserManager')
      }
    ]
  }
]
const homeRouter = [
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
        component: () => import('@/pages/Home'),
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
      component: () => import('@/pages/Home'),
      meta: {
        title: 'star',
        icon: 'star'
      }
    }]
  },
  {
    path: '/articles',
    component: Layout,
    children: [{
      path: '',
      name: 'article',
      component: () => import('@/pages/Article'),
      meta: {
        title: 'article',
        icon: 'form'
      }
    }]
  }
]

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
export default new Router({
  routes: [...homeRouter, ...constantRouter]
})
export { asyncRouters, homeRouter }
