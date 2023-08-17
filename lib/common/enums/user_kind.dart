enum UserKind { customer, driver, pioneer }

extension UserKindutils on UserKind {
  int get number {
    switch (this) {
      case UserKind.customer:
        return 2;
      case UserKind.driver:
        return 3;
      case UserKind.pioneer:
        return 4;
    }
  }
}
