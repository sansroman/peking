<template>
  <div class="app-container">

    <div style="margin-bottom:20px;">

      <el-button type="primary" size="small" class="option-item">
        <a href="https://github.com/PanJiaChen/vue-element-admin/tree/master/src/components/TreeTable" target="_blank">Documentation</a>
      </el-button>

      <div class="option-item">
        <el-tag>展开全部</el-tag>
        <el-switch
          v-model="defaultExpandAll"
          active-color="#13ce66"
          inactive-color="#ff4949"
          @change="reset"/>
      </div>

      <div class="option-item">
        <el-tag>显示多选框</el-tag>
        <el-switch
          v-model="showCheckbox"
          active-color="#13ce66"
          inactive-color="#ff4949"
        />
      </div>

    </div>

    <tree-table :key="key" :default-expand-all="defaultExpandAll" :data="data" :columns="columns" border>
      <template slot="scope" slot-scope="{scope}">
        <el-tag>level: {{ scope.row._level }}</el-tag>
        <el-tag>expand: {{ scope.row._expand }}</el-tag>
        <el-tag>select: {{ scope.row._select }}</el-tag>
      </template>
      <template slot="operation" slot-scope="{scope}">
        <el-button type="primary" size="" @click="click(scope)">Click</el-button>
      </template>
    </tree-table>

  </div>
</template>

<script>
import treeTable from '@/components/TreeTable'
import data from './data'

export default {
  name: 'Course',
  components: { treeTable },
  data () {
    return {
      defaultExpandAll: false,
      showCheckbox: true,
      key: 1,
      columns: [
        {
          checkbox: true,
          width: 70,
          expand: true
        },
        {
          label: '课程编号',
          key: 'id',
          expand: true,
          width: 100
        },
        {
          label: '课程名称',
          key: 'name',
          width: 100
        },
        {
          label: '任课老师',
          key: 'teacher',
          width: 100
        },
        {
          label: '课程章节',
          key: 'chapter'
        },
        {
          label: '观看进度',
          key: 'process'
        },
        {
          label: '操作',
          key: 'operation'
        }
      ],
      data: data
    }
  },
  watch: {
    showCheckbox (val) {
      if (val) {
        this.columns.unshift({
          label: 'Checkbox',
          checkbox: true
        })
      } else {
        this.columns.shift()
      }
      this.reset()
    }
  },
  methods: {
    reset () {
      ++this.key
    },
    click (scope) {
      console.log(scope)

      const row = scope.row
      const message = Object.keys(row)
        .map(i => {
          return `<p>${i}: ${row[i]}</p>`
        })
        .join('')

      this.$notify({
        title: 'Success',
        dangerouslyUseHTMLString: true,
        message: message,
        type: 'success'
      })
    }
  }
}
</script>

<style scoped>
.option-item{
  display: inline-block;
  margin-right: 15px;
}
</style>
