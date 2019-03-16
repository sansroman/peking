<template>
  <el-table :data="tableData" :row-style="showRow" v-bind="$attrs" v-on="$listeners">
    <slot name="selection"/>
    <slot name="pre-column"/>
    <el-table-column
      v-for="item in columns"
      :label="item.label"
      :key="item.key"
      :width="item.width"
      :align="item.align||'center'"
      :header-align="item.headerAlign"
    >
      <template slot-scope="scope">
        <slot :scope="scope" :name="item.key">
          <template v-if="item.expand">
            <span :style="{'padding-left':+scope.row._level*indent + 'px'} "/>
            <span
              v-show="showSperadIcon(scope.row)"
              class="tree-ctrl"
              @click="toggleExpanded(scope.$index)"
            >
              <i v-if="!scope.row._expand" class="el-icon-plus"/>
              <i v-else class="el-icon-minus"/>
            </span>
          </template>
          <template v-if="item.checkbox">
            <el-checkbox
              v-if="scope.row[defaultChildren]&&scope.row[defaultChildren].length>0"
              :style="{'padding-left':+scope.row._level*indent + 'px'} "
              :indeterminate="scope.row._select"
              v-model="scope.row._select"
              @change="handleCheckAllChange(scope.row)"
            />
            <el-checkbox
              v-else
              :style="{'padding-left':+scope.row._level*indent + 'px'} "
              v-model="scope.row._select"
              @change="handleCheckAllChange(scope.row)"
            />
          </template>
          {{ scope.row[item.key] }}
        </slot>
      </template>
    </el-table-column>
  </el-table>
</template>

<script>
import Vue from 'vue'
export default {
  name: 'TreeTable',
  props: {
    data: {
      type: Array,
      required: true,
      default: () => []
    },
    columns: {
      type: Array,
      default: () => []
    },
    defaultExpandAll: {
      type: Boolean,
      default: false
    },
    defaultChildren: {
      type: String,
      default: 'children'
    },
    indent: {
      type: Number,
      default: 50
    }
  },
  data () {
    return {
      guard: 1
    }
  },
  computed: {
    children () {
      return this.defaultChildren
    },
    tableData () {
      const data = this.data
      if (this.data.length === 0) {
        return []
      }
      this.addAttrs(data, {
        expand: this.defaultExpandAll,
        children: this.defaultChildren
      })

      const retval = this.treeToArray(data, this.defaultChildren)
      return retval
    }
  },
  methods: {
    addBrother (row, data) {
      if (row._parent) {
        row._parent.children.push(data)
      } else {
        this.data.push(data)
      }
    },
    addChild (row, data) {
      if (!row.children) {
        this.$set(row, 'children', [])
      }
      row.children.push(data)
    },
    delete (row) {
      const { _index, _parent } = row
      if (_parent) {
        _parent.children.splice(_index, 1)
      } else {
        this.data.splice(_index, 1)
      }
    },
    getData () {
      return this.tableData
    },
    showRow: function ({ row }) {
      const parent = row._parent
      const show = parent ? parent._expand && parent._show : true
      // eslint-disable-next-line
      row._show = show
      return show
        ? 'animation:treeTableShow 1s;-webkit-animation:treeTableShow 1s;'
        : 'display:none;'
    },
    showSperadIcon (record) {
      return record[this.children] && record[this.children].length > 0
    },
    toggleExpanded (trIndex) {
      const record = this.tableData[trIndex]
      const expand = !record._expand
      record._expand = expand
    },
    handleCheckAllChange (row) {
      this.selcetRecursion(row, row._select, this.defaultChildren)
      this.isIndeterminate = row._select
    },
    selcetRecursion (row, select, children = 'children') {
      if (select) {
        this.$set(row, '_expand', true)
        this.$set(row, '_show', true)
      }
      const subItem = row[children]
      if (subItem && subItem.length > 0) {
        subItem.map(child => {
          // eslint-disable-next-line
          child._select = select
          this.selcetRecursion(child, select, children)
        })
      }
    },
    treeToArray (data, children = 'children') {
      let tmp = []
      data.forEach((item, index) => {
        Vue.set(item, '_index', index)
        tmp.push(item)
        if (item[children] && item[children].length > 0) {
          const res = this.treeToArray(item[children], children)
          tmp = tmp.concat(res)
        }
      })
      return tmp
    },
    addAttrs (
      data,
      {
        parent = null,
        preIndex = false,
        level = 0,
        expand = false,
        children = 'children',
        show = true,
        select = false
      } = {}
    ) {
      data.forEach((item, index) => {
        const _id = (preIndex ? `${preIndex}-${index}` : index) + ''
        Vue.set(item, '_id', _id)
        Vue.set(item, '_level', level)
        Vue.set(item, '_expand', expand)
        Vue.set(item, '_parent', parent)
        Vue.set(item, '_show', show)
        Vue.set(item, '_select', select)
        if (item[children] && item[children].length > 0) {
          this.addAttrs(item[children], {
            parent: item,
            level: level + 1,
            expand,
            preIndex: _id,
            children,
            status,
            select
          })
        }
      })
    },

    cleanParentAttr (data, children = 'children') {
      data.forEach(item => {
        // eslint-disable-next-line
        item._parent = null
        if (item[children] && item[children].length > 0) {
          this.addAttrs(item[children], children)
        }
      })
      return data
    }
  }
}
</script>

<style>
@keyframes treeTableShow {
  from {
    opacity: 0;
  }
  to {
    opacity: 1;
  }
}
@-webkit-keyframes treeTableShow {
  from {
    opacity: 0;
  }
  to {
    opacity: 1;
  }
}

.tree-ctrl {
  position: relative;
  cursor: pointer;
  color: #2196f3;
}
</style>
