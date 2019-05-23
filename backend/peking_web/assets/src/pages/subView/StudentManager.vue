<template>
  <div class="app-container">
    <el-table :data="tableData" id="out-table" v-loading="loading">
      <template v-for="column in tableColumns">
        <el-table-column
          :formatter="column.formatter"
          :width="column.label == 'id' ? 80 : ''"
          align="center"
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
import { getRoomUsers } from '@/api/room'
import { mapGetters } from 'vuex'

const ROLE = ['学生', '教师', '管理员']
export default {
  name: 'StudentManager',
  data () {
    return {
      tableColumns: [
        {
          label: 'id',
          prop: 'id'
        },
        {
          label: '姓名',
          prop: 'nickname'
        },
        {
          label: '介绍',
          prop: 'introduction'
        },
        {
          label: '角色',
          prop: 'role',
          formatter: row => ROLE[row.role]
        },
        {
          label: '关注时间',
          prop: 'inserted_at'
        }
      ],
      tableData: [],
      count: 1,
      loading: false
    }
  },
  computed: {
    ...mapGetters(['room'])
  },
  created () {
    getRoomUsers(this.room.id).then(res => (this.tableData = res.data.users))
  },
  methods: {

  }
}
</script>
