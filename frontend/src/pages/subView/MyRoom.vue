<template>
  <div class="user">
    <!-- <el-card class="card"> -->
      <h2 style="margin-bottom:20px; font-weight:600">直播间管理</h2>
          <el-form
            :model="userData"
            ref="userDataForm"
            label-width="90px"
            class="userDataForm"
            style="weight:100%"
          >
          <el-row >
            <el-col :span="10"> 
              <el-form-item
              label="房间ID:"
              prop="id"
            >
              <el-input
                v-model="userData.id"
                size="small"
                disabled
              >

              </el-input>
            </el-form-item>
            <el-form-item label="房间封面:">
              <el-upload
                class="avatar-uploader"
                action="/api/upload"
                :show-file-list="false"
                :on-success="handleAvatarSuccess"
              >
                <img
                  v-if="userData.avatar"
                  :src="userData.avatar"
                  class="avatar"
                >
                <i
                  v-else
                  class="el-icon-plus avatar-uploader-icon"
                ></i>
              </el-upload>

            </el-form-item>
            <el-form-item
              label="房间名:"
              prop="username"
            >
              <el-input
                v-model="userData.username"
                size="small"
              >

              </el-input>
            </el-form-item>
 
            <el-form-item>
              <el-button size="small">
                提交
              </el-button>
            </el-form-item>
            </el-col>
          <el-col :span="12" :gutter="20">
                  <el-form-item
              label="Token:"
              prop="token"
              disabled
            >
              <el-input
                v-model="userData.token"
                size="small"
              >

              </el-input>
            </el-form-item>
          </el-col>
          </el-row>
          </el-form>
  
    <!-- </el-card> -->
  </div>
</template>
<script>

export default {
  data () {
    return {
      userData: {
        username: '',
        avatar:
          'http://bipu.oss-cn-beijing.aliyuncs.com/egg-multipart-test/akari.jpg',
        token: '',
        id: 18700000000
      },

      activeName: 'first',
      SMStext: '获取短信验证码',
      userRules: {
        username: [
            { required: true, message: '请输入用户名', trigger: 'blur' },
            { min: 3, max: 15, message: '长度在 2 到 15 个字符', trigger: 'blur' }
        ],
        signature: [
            { required: true, message: '请输入个人介绍', trigger: 'blur' },
            { min: 3, max: 30, message: '长度在 1 到 30 个字符', trigger: 'blur' }
        ]
      },
      securityRules: {
        oldPass: [
            { required: true, message: '请输入旧密码', trigger: 'blur' },
            { min: 6, max: 16, message: '长度在 6 到 16 个字符', trigger: 'blur' }
        ],
        newPass: [
            { required: true, message: '请输入新密码', trigger: 'blur' },
            { min: 6, max: 16, message: '长度在 6 到 16 个字符', trigger: 'blur' }
        ]
      },
      smsFlag: '',
      res_sms: '',
      loginTipMsg: ''
    }
  },
  components: {},
  methods: {
  handleAvatarSuccess1 (res, file) {
    this.userData.avatar = res.url
    this.userData.avatar = URL.createObjectURL(file.raw)
  },
  },


}
</script>
<style lang="scss" scoped>

.user {
  
    width: 980px;
    margin: 20px auto 30px auto;
    padding: 20px;
    min-height: 720px;
    .userDataForm {
      width: 980px;
    }
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
