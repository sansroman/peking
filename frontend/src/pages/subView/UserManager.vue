<style scoped>
.user-wrap {
  margin: 20px;
}
.search-place {
  height: 50px;
}
.el-input {
  float: left;
  width: 30%;
}
.selectRole {
  float: right;
}
.searchBtn {
  margin-left: 30px;
}
.el-dropdown-link {
  cursor: pointer;
  color: #409eff;
}
.el-icon-arrow-down {
  font-size: 12px;
}
.options {
  margin: 10px;
}
.uploadExcel input[type="file"] {
  display: none;
}
.blockPage {
  text-align: center;
  margin-top: 20px;
  margin-bottom: -50px;
}
.op-tag {
  margin-left: 10px;
}
</style>
<!-- 用户管理组件 -->
<template>
  <div class="user-wrap">
    <div class="search-place">
      <el-input placeholder="请输入要搜索用户名或昵称" v-model="inputSearch" clearable></el-input>
      <el-button class="searchBtn" @click="searchUser()">搜索</el-button>
      <el-button type="success" @click="resetAll" class="searchBtn">重置</el-button>
    </div>
    <el-table :data="tableData" id="out-table" v-loading="loading">
      <template v-for="column in tableColumns">
        <el-table-column
          :width="column.label == 'id' ? 80 : ''"
          align="center"
          :label="column.label"
          :prop="column.prop"
          :key="column.index"
        ></el-table-column>
      </template>
      <el-table-column label="操作" prop>
        <template slot-scope="scope">
          <el-button @click="modifyUser(scope.row)" type="text" size="small">修改</el-button>
          <el-button @click="deleteUser(scope.row)" type="text" size="small">删除</el-button>
        </template>
      </el-table-column>
    </el-table>
    <div class="blockPage">
      <el-pagination
        layout="prev, pager, next"
        @current-change="handleCurrentChange"
        :total="count"
      ></el-pagination>
    </div>
  </div>
</template>

<script>
export default {
  data () {
    return {
      inputSearch: '',
      tableColumns: [
        {
          label: 'id',
          prop: 'id'
        },
        {
          label: '用户名',
          prop: 'username'
        },
        {
          label: '昵称',
          prop: 'nickname'
        },
        {
          label: '身份',
          prop: 'role'
        },
        {
          label: '创建时间',
          prop: 'created_at'
        },
        {
          label: 'email',
          prop: 'email'
        }
      ],
      tableData: [{
        id: 123,
        username: 'sans',
        nickname: '123',
        role: 'admin',
        created_at: '2019-04-13',
        email: 'sansroman@foxmail.com'
      }],
      count: 1,
      loading: false
    }
  },
  async created () {},
  mounted () {},
  methods: {
    searchUser () {},
    resetAll () {},
    modifyUser () {},
    deleteUser () {},
    handleCurrentChange () {}
  }
}
</script>
