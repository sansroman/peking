<template>
  <div class="live_basic" :style="{height:live_basic_height+'px'}">
    <el-dialog v-el-drag-dialog :visible.sync="editorVisible" title="编辑器">
      <div class="title">
        <span>请谈谈你对线性代数这门科学的看法</span>
      </div>
      <markdown-editor
        ref="markdownEditor"
        v-model="content"
        :options="{hideModeSwitch:true,previewStyle:'tab'}"
        height="200px"
      />
      <div class="operating">
        <el-button type="primary" @click="handleSubmit">提交</el-button>
        <el-button>重置</el-button>
      </div>
    </el-dialog>
    <div class="live_bg"></div>
    <div class="live_show">
      <el-row>
        <el-col :span="left">
          <div class="live_play">
            <div class="left_header">
              <el-row>
                <el-col :span="3">
                  <img :src="live.cover" class="user-avatar">
                </el-col>
                <el-col :span="18">
                  <el-row>
                    <el-col :span="2" style="overflow:hidden;">
                      <el-tag size="mini" type="success" style="margin-top:5px;">直播</el-tag>
                    </el-col>
                    <el-col :span="8">
                      <h1>{{live.title}}</h1>
                    </el-col>
                    <el-col :span="10">
                      <p>{{live.category}}</p>
                    </el-col>
                  </el-row>

                  <el-row class="live_header_morinfo">
                    <el-col :span="4">
                      <div>{{live.owner}}</div>
                    </el-col>
                    <el-col :span="3">
                      <div class="live_ranking">
                        <svg-icon icon-class="chart"/>
                        {{live.ranking}}
                      </div>
                    </el-col>
                    <el-col :span="16">
                      <svg-icon icon-class="eye-open"/>
                      {{live.online}}
                    </el-col>
                  </el-row>
                </el-col>
                <el-col :span="3">
                  <Button type="primary" class="movie_butten">
                    <svg-icon icon-class="star"/>关注
                  </Button>
                </el-col>
              </el-row>
            </div>

            <div class="left_main">
              <video controls id="videoElement" :style="{width: leftheight+'px'}"></video>
            </div>
            <div class="left_bottem">
              <el-row>
                <el-col :span="20"></el-col>
                <el-col :span="4">
                  <el-button
                    type="primary"
                    @click="editorVisible = true"
                    :disabled="!textshow"
                    style="margin-top:20px;"
                  >打开编辑器</el-button>
                </el-col>
              </el-row>
            </div>
          </div>
        </el-col>
        <el-col :span="right" style="padding:10px 5px">
          <div class="live_info" v-show="rightshow">
            <div class="right_header">
              <h1>教师助理</h1>
              <img src="./hedda2.png" alt>
              <img src="./hdsad3.png" alt>
              <img src="./hedda2.png" alt>
            </div>
            <div class="right_main">
              <div class="live_massge">
                <ul class="live_comments">
                  <li v-for="comm in comments" :key="comm.index">
                    <p>
                      <span>{{comm.nickname}}:</span>
                      {{comm.body}}
                    </p>
                  </li>
                </ul>
              </div>
            </div>
            <div class="live_comm">
              <el-row class="comm_buttonBar">
                <el-col :span="7" style="color:#1e88e5;font-size:16px;">讨论主题:</el-col>
                <el-col :span="16" style="font-size:16px; text-align:left;">{{discuss_title}}</el-col>
              </el-row>

              <el-input
                class="comm_input"
                v-model="user_comment"
                type="textarea"
                :el-rows="3"
                placeholder="在此输入....."
              ></el-input>
            </div>
            <span class="count">剩余讨论时间{{surplusTime}} s</span>
            <Button type="primary" class="comm_sent" @click="sendMessage">发送</Button>
          </div>
        </el-col>
      </el-row>
    </div>
  </div>
</template>
<script>
import flvjs from 'flv.js'
import elDragDialog from '@/directive/drag'
import MarkdownEditor from '@/components/MarkdownEditor'
import { getRoomInfo } from '@/api/room'
import { Socket } from 'phoenix-socket'

export default {
  directives: { elDragDialog },
  data () {
    return {
      editorVisible: false,
      live_basic_height: 800,
      left: 18,
      right: 6,
      leftheight: 878,
      surplusTime: '',
      client: '',
      content: '',
      user_comment: '',
      textshow: false,
      rightshow: false,
      discuss_title: '',
      live: {},
      comments: [],
      radio: '1',
      channel: {}
    }
  },
  methods: {
    getRoomInfo () {
      getRoomInfo(this.$route.params.id).then(res => {
        this.live = res.data
      })
    },
    joinChannel () {
      let socket = new Socket('ws://localhost:4000/socket')
      socket.connect()
      this.channel = socket.channel(`room:${this.$route.params.id}`, {})
      this.channel
        .join()
        .receive('ok', resp => console.log('Joined successfully', resp))
        .receive('error', resp => console.log('Unable to join', resp))
      this.channel.on('new_msg', this.handleMsg)
    },
    connectVideo () {
      if (flvjs.isSupported()) {
        const videoElement = document.getElementById('videoElement')
        const flvPlayer = flvjs.createPlayer({
          type: 'flv',
          url: `http://localhost:9090/live/${this.$route.params.id}.flv`
        })
        flvPlayer.attachMediaElement(videoElement)
        flvPlayer.load()
        flvPlayer.play()
      }
    },
    handleMsg (resp) {
      this.comments.push(resp)
    },
    handleSubmit () {
      this.editorVisible = false
    },
    handleDiscuss ({ time, title }) {
      this.rightshow = true
      this.surplusTime = time
      this.discuss_title = title
    },
    sendMessage () {
      const uid = this.$store.state.user.uid
      this.channel.push('new_msg', { uid, body: this.user_comment })
      this.user_comment = ''
    },
    changesmall: function (type) {
      if (type) {
        this.rihgtshow = true
        this.left = 18
        this.right = 6
        this.leftheight = 878
        this.getCode()
        this.live_basic_height = 800
      } else {
        //   console.log("ssssss")
        this.rihgtshow = false
        this.left = 24
        this.right = 0
        this.leftheight = 1178
        this.live_basic_height = 950
      }
    }
  },
  created () {
    this.getRoomInfo()
  },
  mounted () {
    this.connectVideo()
    this.joinChannel()
  },
  components: { MarkdownEditor }
}
</script>

<style rel="stylesheet/scss" lang="scss">
.live_basic {
  background-color: #f2f3f5;
  animation: all 5s ease-in;
  color: #495060;
  h1 {
    font-weight: 500;
    font-size: 23px;
    margin: 0px;
    padding: 0px;
  }
  p {
    margin: 0px;
    padding: 0px;
  }
}
.live_bg {
  background: url("./bg.webp") 0 0 /100% 100% no-repeat;
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
  height: 700px;
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
  height: 100px;
  .user-avatar {
    width: 66px;
    height: 66px;
  }
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
.sssadasdas {
  margin: 5px 0px 10px 0px;
}
</style>
