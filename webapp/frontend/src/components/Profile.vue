<template>
	<div class="container">
		<header class="jumbotron">
			<h3>
				<strong>{{ currentUser.username }}</strong> Profile
			</h3>
		</header>
		<p>
			<strong>Token:</strong>
			{{ currentUser.accessToken.substring(0, 20) }} ...
			{{
				currentUser.accessToken.substr(
					currentUser.accessToken.length - 20
				)
			}}
		</p>
		<p>
			<strong>Id:</strong>
			{{ currentUser.id }}
		</p>
		<p>
			<strong>Email:</strong>
			{{ currentUser.email }}
		</p>
		<strong>Authorities:</strong>
		<ul>
			<li v-for="(role, index) in currentUser.roles" :key="index">
				{{ role }}
			</li>
		</ul>
		<strong>Clusters:</strong>
		<!-- <li v-for="cluster in fetchClusters" :key="cluster">
			{{ cluster }}
		</li> -->
		{{ fetchClusters }}

		<br /><br /><br />
		<strong>Add a cluster:</strong>

		<form name="form" @submit.prevent="handleSubmit">
			<div class="form-group">
				<label for="serverAddress">Server address</label>
				<input
					v-model="cluster.serverAddress"
					v-validate="'required'"
					type="text"
					class="form-control"
					name="serverAddress"
				/>
				<div
					v-if="errors.has('serverAddress')"
					class="alert alert-danger"
					role="alert"
				>
					Server address is required!
				</div>
			</div>
			<div class="form-group">
				<label for="serverLogin">Server login</label>
				<input
					v-model="cluster.serverLogin"
					v-validate="'required'"
					type="text"
					class="form-control"
					name="serverLogin"
				/>
				<div
					v-if="errors.has('password')"
					class="alert alert-danger"
					role="alert"
				>
					Server login is required!
				</div>
			</div>
			<div class="form-group">
				<label for="rootPassword">Root password</label>
				<input
					v-model="cluster.rootPassword"
					v-validate="'required'"
					type="text"
					class="form-control"
					name="rootpassword"
				/>
				<div
					v-if="errors.has('rootpassword')"
					class="alert alert-danger"
					role="alert"
				>
					Root password is required!
				</div>
			</div>
			<div class="form-group">
				<button class="btn btn-primary btn-block" :disabled="loading">
					<span
						v-show="loading"
						class="spinner-border spinner-border-sm"
					></span>
					<span>Create</span>
				</button>
			</div>
			<div class="form-group">
				<div v-if="message" class="alert alert-danger" role="alert">
					{{ message }}
				</div>
			</div>
		</form>
	</div>
</template>

<script lang="ts">
import { Component, Vue } from "vue-property-decorator";
import { namespace } from "vuex-class";
import ClusterService from "@/services/ClusterService";
const Auth = namespace("Auth");

@Component
export default class Profile extends Vue {
	@Auth.State("user")
	private currentUser!: any;
	private cluster: any = {
		serverAddress: "",
		serverLogin: "",
		rootPassword: "",
	};

	mounted() {
		if (!this.currentUser) {
			this.$router.push("/login");
		}
	}

	get fetchClusters(): Promise<Object[]> {
		return new Promise((resolve, reject) => {
			ClusterService.getAllClusters(this.currentUser.id).then(
				(response) => {
					console.log(response);
					resolve(response);
				},
				(err) => {
					reject(err);
				}
			);
		});
	}

	handleSubmit() {
		console.log("submitting");
	}

	// data() {
	// 	return {
	// 		currentClusters: ClusterService.getAllClusters(
	// 			this.currentUser.id
	// 		).then(
	// 			(response) => {
	// 				console.log(response.data);

	// 				return response.data;
	// 			},
	// 			(error) => {
	// 				return (
	// 					(error.response && error.response.data) ||
	// 					error.message ||
	// 					error.toString()
	// 				);
	// 			}
	// 		),
	// 	};
	// }
}
</script>
