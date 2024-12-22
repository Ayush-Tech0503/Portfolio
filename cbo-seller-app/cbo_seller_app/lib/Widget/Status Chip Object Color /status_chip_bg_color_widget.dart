import '../../Utils/Theme/constant_colors.dart';

 getStatusColor(String status) {
  switch (status) {
    case "APPROVED":
      return ConstantColor.chipColor;
    case "PENDING":
      return ConstantColor.chipPendingStatus;
    case "FAILED":
      return ConstantColor.chipFailedStatus;
    case "COMPLETED":
      return ConstantColor.chipCompleteStatus;
    case "ACTIVE":
      return ConstantColor.chipCompleteStatus;
      case "DELIVERED":
      return ConstantColor.chipCompleteStatus;
    default:
      return ConstantColor.loginWithOtpButtonColor;
  }
}