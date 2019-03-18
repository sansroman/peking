<template>
  <el-scrollbar wrap-class="scrollbar-wrapper">
    <el-menu
      :default-active="$route.path"
      :collapse="isCollapse"
      :background-color="variables.menuBg"
      :text-color="variables.menuText"
      :active-text-color="variables.menuActiveText"
      mode="vertical"
    >
      <sidebar-item
        v-for="route in homeRouter"
        :key="route.path"
        :item="route"
        :base-path="route.path"
      />
    </el-menu>
  </el-scrollbar>
</template>

<script>
import variables from '@/styles/variables.scss'
import { mapGetters } from 'vuex'
import SidebarItem from './SidebarItem'
import { homeRouter } from '@/router'
export default {
  components: { SidebarItem },
  data () {
    return { homeRouter }
  },
  computed: {
    ...mapGetters(['sidebar']),
    variables () {
      return variables
    },
    isCollapse () {
      return !this.sidebar.opened
    }
  }
}
</script>
