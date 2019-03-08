import Vue from 'vue'
import Router from 'vue-router'
import Layout from '@/pages/layout/Layout'

Vue.use(Router)

export default new Router({
  routes: [
    {
      path: '/',
      name: 'Home',
      component: Layout,
    },
    {
      path: '/404',
      component: () => import('@/pages/404'),
    },
    {
      path: '/login',
      component: () => import('@/pages/Login'),
    },
  ],
})
