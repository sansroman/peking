<template>
  <div class="user">
    <!-- <el-card class="card"> -->
    <h2 style="margin-bottom:20px; font-weight:600">直播间管理</h2>

    <el-row>
      <el-col :span="10">
        <el-form
          :model="roomData"
          ref="roomForm"
          label-width="90px"
          class="roomForm"
          style="weight:100%"
        >
          <el-form-item label="房间ID:">
            <el-input v-model="room_id" size="small" disabled></el-input>
          </el-form-item>
          <el-form-item label="房间封面:">
            <el-upload
              class="avatar-uploader"
              action=""
              :http-request="handleupload"
              :show-file-list="false"
            >
              <img v-if="room.cover" :src="room.cover" class="avatar">
              <i v-else class="el-icon-plus avatar-uploader-icon"></i>
            </el-upload>
          </el-form-item>
          <el-form-item label="房间名:" prop="title">
            <el-input v-model="room.title" size="small"></el-input>
          </el-form-item>
          <el-form-item>
            <el-button size="small" @click="startLive">开始直播</el-button>
            <el-button size="small" @click="stopLive">停止直播</el-button>
          </el-form-item>
        </el-form>
        Token: <el-input v-model="token" size="small" disabled></el-input>
      </el-col>
      <el-col :span="12" :gutter="20">
        <el-form
          :model="discuss"
          ref="discussForm"
          label-width="90px"
          class="discussForm"
          style="weight:100%"
        >
          <el-form-item label="讨论题目:" prop="title">
            <el-input size="small" v-model="discuss.title"></el-input>
          </el-form-item>
          <el-form-item label="讨论时间:" prop="time">
            <div class="block">
              <el-slider v-model="discuss.time"></el-slider>
            </div>
          </el-form-item>
          <el-form-item>
            <el-button size="small"  @click="startDiscuss">开始</el-button>
          </el-form-item>
        </el-form>
      </el-col>

      <el-col :span="12" :gutter="20">
        <el-form
          :model="quiz"
          ref="quizForm"
          label-width="90px"
          class="quizForm"
          style="weight:100%"
        >
          <el-form-item label="测试题目:" prop="title">
            <el-input size="small" v-model="quiz.topic"></el-input>
          </el-form-item>
          <el-form-item>
            <el-button size="small"  @click="startQuiz">开始</el-button>
          </el-form-item>
        </el-form>
      </el-col>
    </el-row>

    <!-- </el-card> -->
  </div>
</template>
<script>
import COS from 'cos-js-sdk-v5'
import { SecretId, SecretKey } from '../../../secret.json'
import { mapGetters } from 'vuex'
import * as RoomApi from '@/api/room'

export default {
  data () {
    return {
      room_id: 0,
      roomData: {
        title: '',
        cover: ''
      },
      token: '',
      discuss: {
        time: 0,
        title: ''
      },
      quiz: {
        topic: ''
      },
      userRules: {
        title: [
          { required: true, message: '请输入房间名', trigger: 'blur' },
          { min: 3, max: 15, message: '长度在 2 到 15 个字符', trigger: 'blur' }
        ]
      }
    }
  },
  components: {},
  mounted () {
    const { id, title, cover } = this.room
    this.room_id = id
    this.roomData = { title, cover }
  },
  computed: {
    ...mapGetters(['room'])
  },
  methods: {
    handleupload (param) {
      const cos = new COS({ SecretId, SecretKey })
      const name = param.file.name
      cos.putObject({
        Bucket: 'liqiu-1251740680', /* 必须 */
        Region: 'ap-beijing', /* 必须 */
        Key: name, /* 必须 */
        StorageClass: 'STANDARD',
        Body: param.file, // 上传文件对象
        onProgress: function (progressData) {
          console.log(JSON.stringify(progressData))
        }
      }, (err, data) => {
        if (err) alert('上传失败')
        else this.room.cover = `https://liqiu-1251740680.cos.ap-beijing.myqcloud.com/${name}`
      })
    },
    startLive () {
      RoomApi.startLive({ ...this.roomData }).then(({ data, status, error }) => {
        if (status) {
          this.$message({
            message: '获取Token成功',
            type: 'success'
          })
          this.token = data.data.token
        } else this.$message.error('获取token失败')
      })
    },
    stopLive () {
      RoomApi.stopLive().then(({ data, status, error }) => {
        if (status) {
          this.$message({
            message: '关闭成功',
            type: 'success'
          })
        } else this.$message.error('关闭失败，请稍后再试')
      })
    },
    startDiscuss () {
      RoomApi.startDiscuss({ ...this.discuss }).then(({ data, status, error }) => {
        if (status) this.$message({ message: '开始讨论', type: 'success' })
        else this.$message.error('开始失败')
      })
    },
    startQuiz () {
      RoomApi.startQuiz({ quiz: { ...this.quiz } }).then(({ data, status, error }) => {
        if (status) this.$message({ message: '开始测验', type: 'success' })
        else this.$message.error('开始失败')
      })
    }

  }
}
</script>
<style lang="scss" scoped>
.user {
  width: 1280px;
  margin: 20px auto 30px auto;
  padding: 20px;
  min-height: 720px;
  .img-bar {
    height: 180px;
    &:hover {
      .img-info {
        display: block;
      }
    }
    img {
      z-index: 1;
    }
    .img-info {
      cursor: pointer;
      height: 23px;
      display: none;
      background-color: rgba(66, 66, 66, 0.5);
      color: #fff;
      text-align: center;
      font-size: 14px;
      line-height: 23px;
      margin-top: -27px;
      z-index: 2;
      width: 180px;
      position: relative;
      &:hover {
        color: #ab47bc;
      }
    }
  }
  .node {
    height: 83px;
    margin-top: 40px;
    padding-top: 12px;
    background: #f8f8f8;
    padding-left: 30px;
    border: 1px solid #dfdfdf;
    color: #666;
    span {
      font-size: 38px;
    }
    h3 {
      margin-top: 3px;
      font-size: 18px;
      font-weight: 600;
    }
  }

  .avatar-uploader .el-upload {
    border: 1px dashed #d9d9d9;
    border-radius: 6px;
    cursor: pointer;
    position: relative;
    overflow: hidden;
  }
  .avatar-uploader .el-upload:hover {
    border-color: #409eff;
  }
  .avatar-uploader-icon {
    border: 1px solid red;
    font-size: 28px;
    color: #8c939d;
    width: 178px;
    height: 178px;
    line-height: 178px;
    text-align: center;
  }
  .avatar {
    width: 178px;
    height: 178px;
    display: block;
  }
}
</style>
<style >
.user .card .el-card__body {
  padding: 0px !important;
}
</style>
