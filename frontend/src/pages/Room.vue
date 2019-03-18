<template>
  <div class="room" :style="{height:live_basic_height+'px'}">
    <el-dialog v-el-drag-dialog :visible.sync="dialogTableVisible" title="编辑器" @dragDialog="handleDrag">
      <div class="title">
        <span>请谈谈你对线性代数这门科学的看法</span>
      </div>
      <markdown-editor ref="markdownEditor" v-model="content" :options="{hideModeSwitch:true,previewStyle:'tab'}" height="200px"/>
      <div class="operating">
        <el-button type="primary">提交</el-button>
        <el-button>重置</el-button>
      </div>
    </el-dialog>
    <el-row>
      <el-col class="live_play" :span="18" :gutter="20">
        <el-row class="left_header">
          <el-col :span="3">
            <img
              src="https://wpimg.wallstcn.com/f778738c-e4f8-4870-b634-56703b4acafe.gif"
              class="user-avatar"
            >
            <span style="margin-left: 20px">{{live.teacher}}</span>
          </el-col>
          <el-col :span="18">
            <el-row>
              <el-col :span="8" style="overflow:hidden;">
                <h1>{{newTitle}}</h1>
              </el-col>
              <el-col :span="10">
                <p>{{live.classification}}</p>
              </el-col>
            </el-row>
            <el-row class="live_header_morinfo">
              <el-col :span="4">
              </el-col>
              <el-col :span="3">
                <div class="live_ranking">
                  <svg-icon class-name="search-icon" icon-class="search"/>
                  {{live.ranking}}
                </div>
              </el-col>
              <el-col :span="16">
                <svg-icon class-name="search-icon" icon-class="search"/>
                {{live.number}}
              </el-col>
            </el-row>
          </el-col>
          <el-col :span="3">
            <Button type="primary" class="movie_butten">
              <svg-icon class-name="search-icon" icon-class="search"/>关注
            </Button>
          </el-col>
        </el-row>
        <el-row class="left_main">
          <video controls id="videoElement"></video>
        </el-row>
        <el-row class="left_bottem">
          <el-col :span="20"></el-col>
          <el-col :span="4">
            <el-button type="primary" @click="dialogTableVisible = true">打开编辑器</el-button>
          </el-col>
        </el-row>
      </el-col>
      <el-col class="live_info" :span="6">
        <div class="right_header">
          <h1>教师助理</h1>
        </div>
        <div class="right_main">
          <div class="live_massge">
            <ul class="live_comments">
              <li v-for="comm in comments" :key="comm">
                <p>
                  <span>{{comm.uname}}:</span>
                  {{comm.utext}}
                </p>
              </li>
            </ul>
          </div>
        </div>
        <div class="live_comm">
          <el-input
            class="comm_input"
            v-model="user_comment"
            type="textarea"
            :el-rows="3"
            placeholder="在此输入....."
          ></el-input>
        </div>
        <span class="count">剩余讨论时间{{count}} s</span>
        <Button type="primary" class="comm_sent" @click="sendMessage()">发送</Button>
      </el-col>
    </el-row>
  </div>
</template>
<script>
import flvjs from 'flv.js'
import elDragDialog from '@/directive/drag'
import MarkdownEditor from '@/components/MarkdownEditor'

export default {
  directives: { elDragDialog },
  data () {
    return {
      dialogTableVisible: false,
      live_basic_height: 950,
      count: '',
      client: '',
      content: '',
      user_comment: '',
      textshow: true,
      innerVisible: false,
      live: {
        title: '线性代数第一章',
        classification: '高等数学',
        teacher: '李永乐老师',
        ranking: '1000',
        user: '',
        number: 1233
      },
      comments: [],
      radio: '1'
    }
  },
  computed: {
    newTitle: function () {
      return this.live.title.length > 8
        ? this.live.title.substring(0, 7) + '...'
        : this.live.title
    }
  },
  methods: {
    sendMessage: function () {
      this.comments.push({ uname: '你自己', utext: this.user_comment })
      this.client.emit('msg', this.user_comment)
      this.user_comment = ''
    },
    submit: function () {
      console.log(this.questions)
      this.$axios
        .post(`live/${this.$route.params.id}/receipt`, {
          data: this.questions
        })
        .then(() => {
          this.$Message.info('提交成功', 3)
        })
      this.innerVisible = false
    },
    innershow: function () {
      this.innerVisible = true
    },
    handleDrag () {
      this.$refs.select.blur()
    }
  },
  created () {},
  components: { MarkdownEditor },
  mounted () {
    if (flvjs.isSupported()) {
      var videoElement = document.getElementById('videoElement')
      var flvPlayer = flvjs.createPlayer({
        type: 'flv',
        url:
          'https://js.live-play.acgvideo.com/live-js/367147/live_180031935_2856100.flv?wsSecret=96885dcd618494307dc7a7436f053ca3&wsTime=1552807059&trid=8cc4d7292c144589be5f92398aa35634&sig=no&platform=web&pSession=12zJ93KY-ymjz-4t1p-h234-1YF6eQ294cXR'
      })
      flvPlayer.attachMediaElement(videoElement)
      flvPlayer.load()
      flvPlayer.play()
    }
  }
}
</script>

<style rel="stylesheet/scss" lang="scss">
.live_basic {
  background-color: #f2f3f5;
  animation: all 5s ease-in;
}
.live_bg {
  position: absolute;
  left: 0;
  right: 0;
  width: 100%;
  height: 800px;
}
.live_show {
  width: 1200px;
  margin: auto;
  padding-top: 15px 0px;
}
.live_play,
.live_info {
  background: #fff;
  border-radius: 10px;
  border: #e1e1e1 1px solid;
}
.left_header img {
  height: 66px;
  border-radius: 40px;
}
.left_header {
  padding: 17px 24px 17px 17px;
  background-color: #23ade5;
}
.left_header h1 {
  font-weight: 500;
  font-size: 23px;
}
.left_header p {
  line-height: 34px;
}
.left_main {
  animation: all 5s ease-in;
}
.left_bottem {
  height: 100px;
  padding: 17px 24px 17px 17px;
  background-color: #fff;
  border-radius: 0px 0px 10px 10px;
  margin-top: -5px;
}
.live_header_morinfo {
  margin-top: 8px;
  font-size: 16px;
}
.live_header_morinfo i {
  font-size: 18px;
  color: deeppink;
}
.right_header {
  height: 120px;
  background-color: #fff;
  border-radius: inherit;
}
.right_main {
  background-color: #eee;
  height: 575px;
  border-radius: 0px 0px 10px 10px;
  border-bottom: #e1e1e1 1px solid;
}
.right_header h1 {
  font-size: 14px;
  width: 100%;
  text-align: center;
  font-weight: 400;
  color: #888;
  border-bottom: 1px #eee solid;
  margin: 4px 0px;
}
.right_header img {
  width: 80px;
  margin-left: 10px;
  margin-top: 5px;
}
.live_massge {
  padding: 5px;
  height: 440px;
}
.live_comments li {
  list-style: none;
  padding: 5px 5px;
}
.live_comments span {
  color: #23ade5;
  font-size: 14px;
  height: 20px;
  font-weight: 500;
}
.live_comments p {
  position: relative;
  color: #646c7a;
  line-height: 20px;
  font-size: 14px;
  font-weight: 400;
  white-space: normal;
  word-wrap: break-word;
  word-break: break-all;
  overflow: hidden;
}
.comm_input {
  padding: 5px 18px;

  line-height: 18px !important;
}
.comm_sent {
  float: right;
  margin-right: 20px;
  padding: 3px 25px;
}
.comm_buttonBar div {
  color: #646c7a;
  font-size: 14px;
  text-align: right;
  font-weight: 500;
  cursor: pointer;
}
.count {
  margin: 20px 0px 0px 20px;
  font-size: 14px;
  color: #23ade5;
}
.user-avatar{
  margin-right: 20px;
}
video {
  width: 100%;
  height: 100%;
}
.el-dialog__body {
  padding: 10px 20px;
  .title {
    margin-bottom: 10px;
  }
  .operating {
    margin-top: 10px;
  }
}

</style>
