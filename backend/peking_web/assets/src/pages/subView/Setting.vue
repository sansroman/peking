<template>
  <div class="components-container">
    <el-row class="header">
      <el-col :span="8">
        <el-upload
          class="avatar-uploader"
          action=""
          :http-request="handleupload"
          :show-file-list="false"
        >
          <img v-if="avatar" :src="avatar" class="avatar">
          <i v-else class="el-icon-plus avatar-uploader-icon"></i>
        </el-upload>
      </el-col>
      <el-col :span="16">
        <panel-group />
      </el-col>

    </el-row>
    <el-row :gutter="10" style="margin-top:50px;">
      <el-col :span="8">
        <pie-chart />
      </el-col>
      <el-col :span="5">
        <box-card/>
      </el-col>
      <el-form :model="userInfo" :rules="userInfo">
        <el-col :span="5">
          <el-card class="box-card">
            <div slot="header" class="clearfix">
              <span>安全设置</span>
            </div>
            <el-form-item prop="username">
              <md-input
                v-model="userInfo.username"
                icon="info"
                name="username"
                placeholder="输入名称"
              >用户名称</md-input>
            </el-form-item>
            <el-form-item prop="password">
              <md-input v-model="userInfo.pasword" icon="info" name="password" placeholder="输入名称">密码</md-input>
            </el-form-item>
            <el-form-item prop="email">
              <md-input v-model="userInfo.email" icon="info" name="email" placeholder="输入名称">个人邮箱</md-input>
            </el-form-item>
            <el-form-item prop="phone">
              <md-input v-model="userInfo.phone" icon="info" name="phone" placeholder="输入名称">手机号码</md-input>
            </el-form-item>
          </el-card>
        </el-col>
        <el-col :span="5">
          <el-card class="box-card">
            <div slot="header" class="clearfix">
              <span>信息设置</span>
            </div>

            <el-form-item prop="class">
              <md-input v-model="userInfo.class" icon="info" name="class" placeholder="输入名称">班级</md-input>
            </el-form-item>
            <el-form-item prop="graduation">
              <md-input
                v-model="userInfo.graduation"
                icon="info"
                name="graduation"
                placeholder="输入名称"
              >毕业时间</md-input>
            </el-form-item>
            <el-form-item prop="signature">
              <md-input
                v-model="userInfo.signature"
                icon="info"
                name="signature"
                placeholder="signature"
              >个性签名</md-input>
            </el-form-item>
            <el-form-item style="padding-top:30px;text-align: center;">
              <el-button type="primary" @click="onSubmit">提交</el-button>
              <el-button>重置</el-button>
            </el-form-item>
          </el-card>
        </el-col>
      </el-form>
    </el-row>
  </div>
</template>

<script>
import MdInput from '@/components/MdInput'
import BoxCard from '@/components/BoxCard'
import PanelGroup from '@/components/PanelGroup'
import PieChart from '@/components/PieChart'
import { mapGetters } from 'vuex'
import COS from 'cos-js-sdk-v5'
import { updateUserInfo } from '@/api/user'
import { SecretId, SecretKey } from '../../../secret.json'

export default {
  name: 'Setting',
  components: { MdInput, BoxCard, PanelGroup, PieChart },
  computed: {
    ...mapGetters(['token', 'name', 'avatar'])
  },
  data () {
    const validate = (rule, value, callback) => {
      if (value.length !== 6) {
        callback(new Error('请输入六个字符'))
      } else {
        callback()
      }
    }
    return {
      imagecropperShow: false,
      imagecropperKey: 0,
      userInfo: {},
      userInfoRules: {
        username: [{ required: true, trigger: 'change', validator: validate }],
        password: [{ required: true, trigger: 'change', validator: validate }],
        signature: [{ required: true, trigger: 'change', validator: validate }],
        email: [{ required: true, trigger: 'change', validator: validate }]
      }
    }
  },
  methods: {
    cropSuccess (resData) {
      this.imagecropperShow = false
      this.imagecropperKey = this.imagecropperKey + 1
      this.image = resData.files.avatar
    },
    close () {
      this.imagecropperShow = false
    },
    onSubmit () {

    },
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
        else {
          updateUserInfo({ id: this.token, user: { avatar: `https://liqiu-1251740680.cos.ap-beijing.myqcloud.com/${name}` } }).then(result => {
            this.$store.commit('SET_AVATAR', `https://liqiu-1251740680.cos.ap-beijing.myqcloud.com/${name}`)
          }).catch(err => {
            console.log(err)
          })
        }
      })
    }
  }
}
</script>

<style scoped>
.avatar {
  width: 200px;
  height: 200px;
  border-radius: 50%;
}
.header{
  padding: 20px 30px;
  background-color: aquamarine
}
</style>
