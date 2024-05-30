<script setup>
import { useStore } from "vuex";
import { showToast } from "@/util";

const store = useStore();
store.dispatch("cuser/signout").then(() => {
  showToast("Signout successful!", "success");
  window.location.href = "/";
});
</script>
