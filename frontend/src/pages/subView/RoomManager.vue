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
    <el-table :data="tableData" id="out-table" v-loading="loading">
      <template v-for="column in tableColumns">
        <el-table-column
          :width="column.label == 'id' ? 80 : ''"
          align="center"
          :formatter="column.formatter"
          :label="column.label"
          :prop="column.prop"
          :key="column.index"
        ></el-table-column>
      </template>
      <el-table-column label="操作" prop>
        <template slot-scope="scope">
          <el-button @click="deleteRoom(scope.row)" type="text" size="small">删除</el-button>
        </template>
      </el-table-column>
    </el-table>
  </div>
</template>

<script>
import { getRoomList, deleteRoom as deleteRoomApi } from '@/api/room'

export default {
  name: 'roomManager',
  data () {
    return {
      inputSearch: '',
      tableColumns: [
        {
          label: 'id',
          prop: 'id'
        },
        {
          label: '姓名',
          prop: 'owner'
        },
        {
          label: '标题',
          prop: 'title'
        },
        {
          label: '类型',
          prop: 'category'
        },
        {
          label: '状态',
          prop: 'status'
        },
        {
          label: '热门',
          prop: 'hot'
        },
        {
          label: '关注人数',
          prop: 'users'
        },
        {
          label: '在线人数',
          prop: 'online'
        }
      ],
      tableData: [],
      count: 1,
      loading: false
    }
  },
  mounted () {
    getRoomList().then(res => (this.tableData = res.data.data))
  },
  methods: {
    deleteRoom ({ id }) {
      deleteRoomApi(id).then(res => res.data.status || this.$message({ message: '删除成功', type: 'success' }))
    },
    cellValueRenderer (row, column, cellValue, index) {
      let value = cellValue
      if (typeof row[column.property] === 'boolean') {
        value = String(cellValue)
      }
      return value
    }
  }
}
</script>
