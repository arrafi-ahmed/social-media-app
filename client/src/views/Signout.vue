<script setup>
import { useStore } from "vuex";
import { useRouter } from "vue-router";
import { showToast } from "@/util";

const store = useStore();
const router = useRouter();
store.dispatch("cuser/signout").then(() => {
  showToast("Signout successful!", "success");
  window.location.href = "/";
});
</script>
