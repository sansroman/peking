<template>
<div id="todo">
  <el-row>
    <div class="panel-group">
      <el-col :xs="12" :sm="12" :lg="6" class="card-panel-col">
        <div class="card-panel">
          <div class="card-panel-icon-wrapper icon-people">
            <svg-icon icon-class="list" class-name="card-panel-icon" />
          </div>
          <div class="card-panel-description">
            <div class="card-panel-text">待办</div>
            <count-to :start-val="0" :end-val="list1.length" :duration="100" class="card-panel-num"/>
          </div>
        </div>
      </el-col>
      <el-col :xs="12" :sm="12" :lg="6" class="card-panel-col">
        <div class="card-panel">
          <div class="card-panel-icon-wrapper icon-message">
            <svg-icon icon-class="example" class-name="card-panel-icon" />
          </div>
          <div class="card-panel-description">
            <div class="card-panel-text">正在进行中</div>
            <count-to :start-val="0" :end-val="list2.length" :duration="100" class="card-panel-num"/>
          </div>
        </div>
      </el-col>
            <el-col :xs="12" :sm="12" :lg="6" class="card-panel-col">
        <div class="card-panel">
          <div class="card-panel-icon-wrapper icon-message">
            <svg-icon icon-class="example" class-name="card-panel-icon" />
          </div>
          <div class="card-panel-description">
            <div class="card-panel-text">已完成</div>
            <count-to :start-val="0" :end-val="list3.length" :duration="100" class="card-panel-num"/>
          </div>
        </div>
      </el-col>
    </div>
  </el-row>
  <el-row>
    <div class="components-container board">
      <Kanban :key="1" :list="list1" :options="options" class="kanban todo" header-text="Todo"/>
      <Kanban :key="2" :list="list2" :options="options" class="kanban working" header-text="Working"/>
      <Kanban :key="3" :list="list3" :options="options" class="kanban done" header-text="Done"/>
    </div>
  </el-row>
</div>
</template>
<script>
import Kanban from '@/components/Kanban'
import CountTo from 'vue-count-to'

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
      list1: [
        { name: '多线程通信 ', id: 1 },
        { name: '分布式', id: 2 },
        { name: '日志记录', id: 3 },
        { name: '错误处理', id: 4 }
      ],
      list2: [
        { name: '容器', id: 5 },
        { name: '线性代数', id: 6 },
        { name: '系统设计', id: 7 }
      ],
      list3: [
        { name: 'Splay', id: 8 },
        { name: 'Treap', id: 9 },
        { name: 'HashMap', id: 10 }
      ]
    }
  }
}
</script>
<style lang="scss">
.board {
  width: 1000px;
  margin-left: 20px;
  display: flex;
  justify-content: space-around;
  flex-direction: row;
  align-items: flex-start;
}
.kanban {
  &.todo {
    .board-column-header {
      background: #4A9FF9;
    }
  }
  &.working {
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
  .card-panel-col{
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
    box-shadow: 4px 4px 40px rgba(0, 0, 0, .05);
    border-color: rgba(0, 0, 0, .05);
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
        background: #34bfa3
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
      color: #34bfa3
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
