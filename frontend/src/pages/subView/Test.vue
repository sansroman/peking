<template>
  <div class="app-container">
    <el-table
      v-loading="listLoading"
      :data="list"
      border
      fit
      highlight-current-row
      style="width: 100%"
    >
      <el-table-column align="center" label="ID" width="80">
        <template slot-scope="scope">
          <span>{{ scope.row.id }}</span>
        </template>
      </el-table-column>

      <el-table-column width="120px" align="center" label="老师">
        <template slot-scope="scope">
          <span>{{ scope.row.teacher }}</span>
        </template>
      </el-table-column>

      <el-table-column min-width="300px" label="标题">
        <template slot-scope="scope">
          <router-link :to="'/test/edit/'+scope.row.id" class="link-type">
            <span>{{ scope.row.title }}</span>
          </router-link>
        </template>
      </el-table-column>

      <el-table-column width="100px" label="评分">
        <template slot-scope="scope">
          <span>{{ scope.row.score }}</span>
        </template>
      </el-table-column>

      <el-table-column class-name="status-col" label="状态" width="110">
        <template slot-scope="scope">
          <el-tag :type="scope.row.score | statusFilter">{{ genStatus(scope.row.score) }}</el-tag>
        </template>
      </el-table-column>

      <el-table-column width="180px" align="center" label="提交时间">
        <template slot-scope="scope">
          <span>{{ scope.row.created_at | parseTime('{y}-{m}-{d} {h}:{i}') }}</span>
        </template>
      </el-table-column>

    </el-table>

  </div>
</template>

<script>
import { fetchList } from '@/api/quiz'
import { parseTime } from '@/utils'
export default {
  name: 'Test',
  filters: {
    statusFilter (score) {
      if (!score) return 'info'
      else return score > 60 ? 'success' : 'warning'
    },
    parseTime
  },
  data () {
    return {
      list: null,
      listLoading: true
    }
  },
  created () {
    this.getList()
  },
  methods: {
    getList () {
      this.listLoading = true
      fetchList(this.listQuery).then(response => {
        this.list = response.data.data
        this.listLoading = false
      })
    },
    handleSizeChange (val) {
      this.listQuery.limit = val
      this.getList()
    },
    handleCurrentChange (val) {
      this.listQuery.page = val
      this.getList()
    },
    genStatus (score) {
      if (!score) return '暂未审核'
      else return score > 60 ? '通过测试' : '未通过测试'
    }
  }
}
</script>

<style scoped>
.edit-input {
  padding-right: 100px;
}
.cancel-btn {
  position: absolute;
  right: 15px;
  top: 10px;
}
</style>
