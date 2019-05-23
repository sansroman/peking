<template>
  <div id="todo">
    <el-row>
      <div class="panel-group">
        <el-col :xs="12" :sm="12" :lg="6" class="card-panel-col">
          <div class="card-panel">
            <div class="card-panel-icon-wrapper icon-people">
              <svg-icon icon-class="list" class-name="card-panel-icon"/>
            </div>
            <div class="card-panel-description">
              <div class="card-panel-text">待办</div>
              <count-to
                :start-val="0"
                :end-val="todo.length"
                :duration="100"
                class="card-panel-num"
              />
            </div>
          </div>
        </el-col>
        <el-col :xs="12" :sm="12" :lg="6" class="card-panel-col">
          <div class="card-panel">
            <div class="card-panel-icon-wrapper icon-message">
              <svg-icon icon-class="example" class-name="card-panel-icon"/>
            </div>
            <div class="card-panel-description">
              <div class="card-panel-text">正在进行中</div>
              <count-to
                :start-val="0"
                :end-val="doing.length"
                :duration="100"
                class="card-panel-num"
              />
            </div>
          </div>
        </el-col>
        <el-col :xs="12" :sm="12" :lg="6" class="card-panel-col">
          <div class="card-panel">
            <div class="card-panel-icon-wrapper icon-message">
              <svg-icon icon-class="example" class-name="card-panel-icon"/>
            </div>
            <div class="card-panel-description">
              <div class="card-panel-text">已完成</div>
              <count-to
                :start-val="0"
                :end-val="done.length"
                :duration="100"
                class="card-panel-num"
              />
            </div>
          </div>
        </el-col>
      </div>
    </el-row>
    <el-row>
      <el-col :span="18">
        <div class="components-container board">
          <Kanban :handleEnded="(a, b) => handleEnded(0, a, b)" :key="1" :list="todo" :options="options" class="kanban todo" header-text="Todo"/>
          <Kanban :handleEnded="(a, b) => handleEnded(1, a, b)" :key="2" :list="doing" :options="options" class="kanban doing" header-text="Doing"/>
          <Kanban :handleEnded="(a, b) => handleEnded(2, a, b)" :key="3" :list="done" :options="options" class="kanban done" header-text="Done"/>
        </div>
      </el-col>
      <el-col class="operation" :span="6">
        <el-button type="primary" @click="create">添加待办事项</el-button>
      </el-col>
    </el-row>
    <el-row></el-row>
  </div>
</template>
<script>
import Kanban from '@/components/Kanban'
import CountTo from 'vue-count-to'
import { addTODO } from '@/api/user'
import { mapGetters } from 'vuex'

export default {
  name: 'TODO',
  components: {
    Kanban,
    CountTo
  },
  data () {
    return {
      options: {
        group: 'mission'
      },
      todo: [],
      doing: [],
      done: []
    }
  },
  computed: {
    ...mapGetters(['todos'])
  },
  mounted () {
    this.todo = this.todos.todo
    this.doing = this.todos.doing
    this.done = this.todos.done
  },
  methods: {
    create () {
      this.$prompt('请输入事项', '提示', {
        confirmButtonText: '确定',
        cancelButtonText: '取消'
      })
        .then(({ value }) => {
          addTODO({ todo: { content: value, status: 0 } }).then(res => {
            this.todo.push({ name: value, id: res.data.data.id })
            this.$message({
              type: 'success',
              message: '添加成功'
            })
          })
        })
        .catch(() => {
          this.$message({
            type: 'info',
            message: '取消输入'
          })
        })
    },
    save () {
      this.$message({
        type: 'success',
        message: '保存成功'
      })
    },
    handleEnded (a, b, c) {
    }
  }
}
</script>
<style lang="scss">
.board {
  width: 1000px;
  display: flex;
  justify-content: space-around;
  flex-direction: row;
  align-items: flex-start;
}
.operation{
  margin-top: 50px;
}
.kanban {
  &.todo {
    .board-column-header {
      background: #4a9ff9;
    }
  }
  &.doing {
    .board-column-header {
      background: #f9944a;
    }
  }
  &.done {
    .board-column-header {
      background: #2ac06d;
    }
  }
}
.panel-group {
  margin-top: 18px;
  .card-panel-col {
    margin: 10px 20px;
  }
  .card-panel {
    height: 108px;
    cursor: pointer;
    font-size: 12px;
    position: relative;
    overflow: hidden;
    color: #666;
    background: #fff;
    box-shadow: 4px 4px 40px rgba(0, 0, 0, 0.05);
    border-color: rgba(0, 0, 0, 0.05);
    &:hover {
      .card-panel-icon-wrapper {
        color: #fff;
      }
      .icon-people {
        background: #40c9c6;
      }
      .icon-message {
        background: #36a3f7;
      }
      .icon-money {
        background: #f4516c;
      }
      .icon-shopping {
        background: #34bfa3;
      }
    }
    .icon-people {
      color: #40c9c6;
    }
    .icon-message {
      color: #36a3f7;
    }
    .icon-money {
      color: #f4516c;
    }
    .icon-shopping {
      color: #34bfa3;
    }
    .card-panel-icon-wrapper {
      float: left;
      margin: 14px 0 0 14px;
      padding: 16px;
      transition: all 0.38s ease-out;
      border-radius: 6px;
    }
    .card-panel-icon {
      float: left;
      font-size: 48px;
    }
    .card-panel-description {
      float: right;
      font-weight: bold;
      margin: 26px;
      margin-left: 0px;
      .card-panel-text {
        line-height: 18px;
        color: rgba(0, 0, 0, 0.45);
        font-size: 16px;
        margin-bottom: 12px;
      }
      .card-panel-num {
        font-size: 20px;
      }
    }
  }
}
</style>
