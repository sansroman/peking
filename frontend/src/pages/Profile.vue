<template>
  <div id="profile">
    <el-menu
      :default-active="activeIndex"
      class="el-menu-demo"
      mode="horizontal"
      :router="true"
      @select="handleSelect"
    >
      <el-menu-item index="/">回到首页</el-menu-item>
      <el-submenu index="study">
        <template slot="title">学习中心</template>
        <el-menu-item index="2-1" :route="{name: 'course'}">我的课程</el-menu-item>
        <el-menu-item index="2-2" :route="{name: 'test'}">我的提交</el-menu-item>
        <el-menu-item index="2-3" :route="{name: 'task'}">我的作业</el-menu-item>
      </el-submenu>
      <el-menu-item index="3" :route="{name: 'statistics'}">学习统计</el-menu-item>
      <el-menu-item index="4" :route="{name: 'todo'}">TODO</el-menu-item>
      <el-menu-item index="5" :route="{name: 'setting'}">个人设置</el-menu-item>
      <el-menu-item class="right-menu">
        <el-dropdown class="avatar-container right-menu-item hover-effect" trigger="click">
          <div class="avatar-wrapper">
            <img :src="avatar+'?imageView2/1/w/80/h/80'" class="user-avatar">
            <i class="el-icon-caret-bottom"/>
          </div>
          <el-dropdown-menu slot="dropdown">
            <router-link to="/profile">
              <el-dropdown-item>profile</el-dropdown-item>
            </router-link>
            <a target="_blank" href="https://github.com/PanJiaChen/vue-element-admin/">
              <el-dropdown-item>github</el-dropdown-item>
            </a>
            <el-dropdown-item divided>
              <span style="display:block;" @click="logout">logOut</span>
            </el-dropdown-item>
          </el-dropdown-menu>
        </el-dropdown>
      </el-menu-item>
    </el-menu>

    <div class="line"></div>

    <router-view></router-view>
  </div>
</template>
<style rel="stylesheet/scss" lang="scss" scoped>
.components-container{
  margin: 0;
}
.right-menu {
  float: right;
  height: 100%;
  line-height: 50px;

  &:focus {
    outline: none;
  }

  .right-menu-item {
    display: inline-block;
    padding: 0 8px;
    height: 100%;
    font-size: 18px;
    color: #5a5e66;
    vertical-align: text-bottom;

    &.hover-effect {
      cursor: pointer;
      transition: background 0.3s;

      &:hover {
        background: rgba(0, 0, 0, 0.025);
      }
    }
  }

  .avatar-container {
    margin-right: 30px;

    .avatar-wrapper {
      margin-top: 5px;
      position: relative;

      .user-avatar {
        cursor: pointer;
        width: 40px;
        height: 40px;
        border-radius: 10px;
      }

      .el-icon-caret-bottom {
        cursor: pointer;
        position: absolute;
        right: -20px;
        top: 25px;
        font-size: 12px;
      }
    }
  }
}
</style>

<script>
import { mapGetters } from 'vuex'
export default {
  name: 'Profile',
  computed: {
    ...mapGetters(['name', 'avatar'])
  },
  data () {
    return {
      activeIndex: '1',
      activeIndex2: '1'
    }
  },
  methods: {
    handleSelect (key, keyPath) {

    },
    logout () {
      this.$store.dispatch('LogOut').then(() => {
        location.reload() // In order to re-instantiate the vue-router object to avoid bugs
      })
    }
  }
}
</script>
