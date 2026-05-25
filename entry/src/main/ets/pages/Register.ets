import router from '@ohos.router';

@Entry
@Component
struct Register {
  @State username: string = '';
  @State password: string = '';
  @State confirmPassword: string = '';

  build() {
    Column({ space: 20 }) {
      Text('账号注册')
        .fontSize(28)
        .fontWeight(FontWeight.Bold)
        .margin({ top: 60, bottom: 20 })

      TextInput({ placeholder: '请设置账号' })
        .onChange((value: string) => { this.username = value; })
        .width('85%')
        .height(50)

      TextInput({ placeholder: '请设置密码' })
        .type(InputType.Password)
        .onChange((value: string) => { this.password = value; })
        .width('85%')
        .height(50)

      TextInput({ placeholder: '请再次确认密码' })
        .type(InputType.Password)
        .onChange((value: string) => { this.confirmPassword = value; })
        .width('85%')
        .height(50)

      // 注册并返回登录
      Button('立即注册')
        .width('85%')
        .height(50)
        .margin({ top: 20 })
        .onClick(() => {
          if (this.username && this.password && this.password === this.confirmPassword) {
            // 注册成功，返回上一页（登录页）
            router.back();
          }
        })

      Button('返回登录')
        .width('85%')
        .height(50)
        .backgroundColor(Color.Transparent)
        .colorBlend('#666666')
        .onClick(() => {
          router.back();
        })
    }
    .width('100%')
    .height('100%')
    .padding(20)
  }
}