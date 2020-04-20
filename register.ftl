!DOCTYPE html
html

head
    meta charset=utf-8
    title商家入驻title
    meta name=viewport
          content=width=device-width, initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=no
    meta content=yes name=apple-mobile-web-app-capable
    meta content=black name=apple-mobile-web-app-status-bar-style
    meta content=telephone=no name=format-detection
    meta http-equiv=Expires content=-1
    meta http-equiv=Cache-Control content=no-cache
    meta http-equiv=Pragma content=no-cache
    meta name=wap-font-scale content=no
    meta http-equiv=X-UA-Compatible content=IE=edge
    script src=${base}resourcescommonjsjquery.jsscript
    script src=${base}resourcesmobilememberjsfont.jsscript
    script src=${base}resourcesmobilememberjsvue.jsscript
    script src=${base}resourcesmobilemyjsaxios.jsscript
    #--axios--
    !-- iconfont --
    link rel=stylesheet href=${base}resourcesmobilemyfontsiconfont.css
    !-- mui --
    script src=${base}resourcesmobilememberjsmui.min.jsscript
    link href=${base}resourcesmobilemembercssmui.min.css rel=stylesheet 
    script src=${base}resourcesmobilememberjsmui.jsscript
    link rel=stylesheet href=${base}resourcesmobilemembercssreset.css

    link rel=stylesheet href=${base}resourcesmobilemembercssOurRuzhu.css
    !-- element-ui --
    link rel=stylesheet href=httpsunpkg.comelement-uilibtheme-chalkindex.css
    !-- 引入组件库 --
    script src=httpsunpkg.comelement-uilibindex.jsscript
head

body
div id=app class=our_ruzhu
    div class=topheader3
        i class=icon-icon-test59 iconfont onclick=window.history.go(-1)i
        h2商家入驻h2
    div
    div id=sjrzAdd
        form class=act_pages id=ct_pages
            div class=bg
                div class=line
                    span商家名称span
                    input type=text name=username id=username v-model=formData.usename
                div
                div class=line
                    span法人姓名span
                    input type=text name=username id=username v-model=formData.name
                div
                div class=line
                    span身份证号码span
                    input type=text name=idcard id=idcard v-model=formData.idcard
                div
                div class=line
                    span身份证件span
                    input type=hidden name=idcardimg style= v-model=formData.idcardimg id=idcardimg
                    div class=right
                        el-upload class=avatar-uploader action=${base}commonfileupload show-file-list=false data=dataType
                                   on-success=idcardImg before-upload=beforeAvatarUpload
                            img v-if=imageUrl2 src=imageUrl2 class=avatar
                            i v-else class=el-icon-plus avatar-uploader-iconi
                        el-upload
                    div
                div
                div class=line
                    span手机号码span
                    input type=number name=mobile id=mobile v-model=formData.mobile 
                div
                div class=line
                    span公司地址span
                    input name=address class=anniu id=address placeholder=请选择地址 v-model=formData.address 
                div
                div class=line
                    span对公账户span
                    input type=text name=bankAccount id=bankAccount v-model=formData.bankAccount
                div
            div
            div class=bg
                div class=line
                    span营业执照span
                    input type=hidden name=licenseImage style= v-model=formData.licenseImage id=licenseImage
                    div class=right
                        el-upload class=avatar-uploader action=${base}commonfileupload show-file-list=false data=dataType
                                   on-success=handleAvatarSuccess before-upload=beforeAvatarUpload
                            img v-if=imageUrl src=imageUrl class=avatar
                            i v-else class=el-icon-plus avatar-uploader-iconi
                        el-upload
                    div
                div
            div
            h2请仔细核对信息，确认无误提交后，我们将在24小时内与您联系h2
            div class=tijiao
                input id= type=button value=提交 @click=submitMsg()
            div
        form

    div
    !-- shuoming --
    div class=shuoming
    div
    !-- footer_tab --
    div class=footer_tab
        ul
            lia href=${base} target=_selfspanspani 首页iali
            lia href=${base}productlist target=_selfspanspani商城iali
            lia href=${base}membercommunityspanspani社区iali
            lia href=${base}cartlist target=_selfspanspani购物车iali
            li class=acta href=${base}memberindex target=_selfspanspani我的iali
        ul
    div
div
script src=${base}resourcesmobilememberjsfootertab.js type=textjavascript charset=utf-8script
style
    .avatar-uploader .el-upload {
        border 1px dashed #d9d9d9;
        border-radius 0.06rem;
        cursor pointer;
        position relative;
        overflow hidden;
        width1.5rem;
        height1.5rem;
        position relative;
    }
    .avatar-uploader .el-uploadhover {
        border-color#999;
    }
    .avatar-uploader-icon {
        font-size0.28rem;
        color #8c939d;
        width 1.5rem;
        height 1.5rem;
        line-height 1.5rem;
        text-align center;
    }
    .avatar {
        max-width 1.5rem;
        height 1.5rem;
        display block;
    }

style
body
script
    new Vue({
        el '#app',
        data() {
            return {
                dataUrl'',
                imageUrl 'httppaomo.artuploadsallimg201907318654141355c9de91ffa39736c0c183b5.jpg',
                imageUrl2 'httppaomo.artuploadsallimg201907318654141355c9de91ffa39736c0c183b5.jpg',
                dataType {
                    fileType 'IMAGE'
                },
                formData{
                    usename'12345',
                    name'12345',
                    idcard'',
                    idcardimg'',
                    mobile'15274410417',
                    address'0000000000000000',
                    bankAccount'1111111111111111',
                    licenseImage '',
                }
            }
        },
        methods {
            handleAvatarSuccess(res, file) {
                this.imageUrl = URL.createObjectURL(file.raw);
                this.formData.licenseImage = URL.createObjectURL(file.raw)
            },
            idcardImg(res, file){
                this.imageUrl2 = URL.createObjectURL(file.raw);
                this.formData.idcardimg = URL.createObjectURL(file.raw)
            },
            beforeAvatarUpload(file) {
                const isJPG = file.type === 'imagejpeg'  file.type === 'imagepng';
                const isLt2M = file.size  1024  1024  2;

                if (!isJPG) {
                    this.$message.error('上传图片只能是 JPG 格式!');
                }
                if (!isLt2M) {
                    this.$message.error('上传图片大小不能超过 2MB!');
                }
                return isJPG && isLt2M;
            },
            Toast(msg,duration){
                duration=isNaN(duration)1000duration;
                var m = document.createElement('div');
                m.innerHTML = msg;
                cssText;
                m.style.cssText=max-width60%;min-width 150px;padding0 14px;height 40px;color rgb(255, 255, 255);line-height 40px;text-align center;border-radius 4px;position fixed;top 50%;left 50%;transform translate(-50%, -50%);z-index 999999;background rgba(0, 0, 0,.7);font-size0.22rem;
                document.body.appendChild(m);
                setTimeout(function() {
                    var d = 0.8;
                    m.style.webkitTransition = '-webkit-transform ' + d + 's ease-in, opacity ' + d + 's ease-in';
                    m.style.opacity = '0';
                    setTimeout(function() { document.body.removeChild(m) }, d  1000);
                }, duration);
            },
            yanzheng;
            regUsename(){
               let len = this.formData.usename.length;
               return  3len && len 20 ;
            },
            regName(){
                let len = this.formData.name.length;
                return  3len && len 20 ;
            },
            regIdcard(){身体份证号码验证;
               let  p = ^[1-9]d{5}(181920)d{2}((0[1-9])(1[0-2]))(([0-2][1-9])10203031)d{3}[0-9Xx]$;
               return p.test(this.formData.idcard);
            },
            regIdcardimg(){
                return this.imageUrl2.length0;
            },
            regMobile(){
                let regMobile = ^(08617951)(13[0-9]15[012356789]17[678]18[0-9]14[57])[0-9]{8}$ ;
                return regMobile.test(this.formData.mobile)
            },
            regBankAccount(){
                let len =  this.formData.bankAccount.length;
                console.log(len)
                let reg = ^([1-9]{1})(d{15}d{18})$ ;
                return  15  len && len20 && reg.test(len);
            },
            regAddress(){
                return this.formData.address.length  10;
            },
            regImg(){
                return this.imageUrl.length0;
            },
            submitMsg(){
                全部通过验证 可以提交;
                if(this.regUsename() && this.regName() && this.regIdcard() && this.regIdcardimg() && this.regMobile() && this.regBankAccount() && this.regImg() && this.regAddress()){
                    this.cleanData();
                    console.log(this.formData,new Date())
                    axios.post('${base}membermobile_businessregisterBusiness',this.formData).then(res={
                        this.Toast('提交成功');
                        this.cleanData();
                        console.log(res.body);
                    }).catch(err={
                        console.log(err);
                        this.Toast('信息提交失败')
                    })
                    this.cleanData();
                }else{
                    if(!this.regUsename()){
                        this.Toast('请填写正确的商户名字');
                        return;
                    }else if(!this.regName()){
                        this.Toast('请填写正确的法人姓名');
                        return;
                    }else if(!this.regIdcard()){
                        this.Toast('请输入正确的法人身份证');
                        return;
                    }else if(!this.regIdcardimg()){
                        this.Toast('请上传法人身份证！');
                        return;
                    }else if(!this.regMobile()){
                        this.Toast('请填写正确的手机号');
                        return;
                    }else if(!this.regAddress()){
                        this.Toast('请填写详细的公司地址');
                        return;
                    }else if(!this.regBankAccount()){
                        this.Toast('请填写有效的银行卡');
                        return;
                    }else if(!this.regImg()){
                        this.Toast('请上传你的营业执照');
                        return;
                    }
                }
            },
            cleanData(){
                清除数据 key 为对象的[];
                for(key in this.formData){
                    this.formData[key] = '';
                }
            }
        }
    });
script
html