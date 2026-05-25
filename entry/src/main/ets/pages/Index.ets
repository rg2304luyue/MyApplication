import router from '@ohos.router';

@Entry
@Component
struct Index {
  @State username: string = '';
  @State password: string = '';

  build() {
    Column({ space: 20 }) {
      Text('我的APP')
        .fontSize(32)
        .fontWeight(FontWeight.Bold)
        .margin({ top: 60, bottom: 20 })
        .colorBlend('#1A1A1A')

      Text('欢迎登录')
        .fontSize(20)
        .colorBlend('#666666')

      // 账号输入框
      TextInput({ placeholder: '请输入账号' })
        .type(InputType.Normal)
        .onChange((value: string) => { this.username = value; })
        .width('85%')
        .height(50)

      // 密码输入框
      TextInput({ placeholder: '请输入密码' })
        .type(InputType.Password)
        .onChange((value: string) => { this.password = value; })
        .width('85%')
        .height(50)

      // 登录按钮 -> 切换至主页
      Button('登录')
        .width('85%')
        .height(50)
        .margin({ top: 20 })
        .onClick(() => {
          if (this.username.trim() !== '' && this.password.trim() !== '') {
            // 使用 replaceUrl 销毁当前页，防止主页回退到登录页
            router.replaceUrl({ url: 'pages/Home' });
          }
        })

      // 注册按钮 -> 切换至注册页
      Button('还没有账号？去注册')
        .width('85%')
        .height(50)
        .backgroundColor(Color.Transparent)
        .colorBlend('#007DFF')
        .onClick(() => {
          // 使用 pushUrl 压入新页面，方便后续回退
          router.pushUrl({ url: 'pages/Register' });
        })
    }
    .width('100%')
    .height('100%')
    .justifyContent(FlexAlign.Start)
    .padding(20)
  }
}